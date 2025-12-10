import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart'
    show AppointmentState;
import 'package:medora/features/appointments/presentation/controller/states/book_appointment_action_state.dart'
    show BookAppointmentActionState;
import 'package:medora/features/appointments/presentation/widgets/payment_selection_sheet.dart'
    show PaymentSelectionSheet;
import 'package:medora/features/payment_gateways/paymob/presentation/view/screens/paymob_payment_screen.dart'
    show PaymobPaymentScreen;
import 'package:medora/features/payment_gateways/paypal/presentation/views/screens/paypal_payment_screen.dart'
    show PaypalPaymentScreen;
import 'package:medora/features/payment_gateways/stripe/presentation/View/Screens/stripe_payment_screen.dart'
    show StripePaymentScreen;

import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../custom_widgets/adaptive_action_button.dart';

/// Payment processing button responsible for opening payment method selection screen
/// and managing appointment booking state and routing to appropriate payment gateways
///
/// This component handles:
/// - Opening bottom sheet for payment method selection
/// - Managing appointment booking states (loading, success, error)
/// - Routing to different payment gateways based on selection
class PaymentProcessingButton extends StatelessWidget {
  final PatientFieldsControllers formControllers;

  const PaymentProcessingButton({super.key, required this.formControllers});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AppointmentCubit,
      AppointmentState,
      BookAppointmentActionState
    >(
      selector: (state) => BookAppointmentActionState(
        bookAppointmentState: state.bookAppointmentState,
        bookAppointmentErrorMessage: state.bookAppointmentError,
        selectedPaymentMethod: state.selectedPaymentMethod,
      ),
      builder: (context, appointmentState) {
        // Monitor appointment state changes and handle them
        _handleAppointmentStateChanges(context, appointmentState);
        return AdaptiveActionButton(
          title: AppStrings.next,
          isEnabled: true,
          isLoading: false,
          onPressed: () => _openPaymentMethodSelection(context),
        );
      },
    );
  }

  /// Open bottom sheet for selecting available payment methods
  ///
  /// This is the first step in the payment process where the user selects
  /// their preferred payment method (Paymob, Stripe, PayPal)
  void _openPaymentMethodSelection(BuildContext context) {
    AppRouter.dismissKeyboard();
    AppAlerts.showCustomBottomSheet(
      context: context,
      appBarBackgroundColor: AppColors.white,
      appBarTitle: 'Payment Method',
      appBarTitleColor: AppColors.black,
      body: PaymentSelectionSheet(formControllers: formControllers),
    );
  }

  /// Manage appointment booking state changes and control routing
  ///
  /// This function monitors booking state and takes appropriate action:
  /// - Loading state: Show loading dialog
  /// - Success state: Route to appropriate payment gateway
  /// - Error state: Show error message to user
  void _handleAppointmentStateChanges(
    BuildContext context,
    BookAppointmentActionState state,
  ) {
    Future.microtask(() {
      if (!context.mounted) return;

      switch (state.bookAppointmentState) {
        case LazyRequestState.loading:
          _showLoadingDialog(context);
          break;
        case LazyRequestState.loaded:
          _handleSuccessfulAppointment(context, state);
          break;
        case LazyRequestState.error:
          _handleAppointmentError(context, state);
          break;
        case LazyRequestState.lazy:
          break;
      }
    });
  }

  /// Show loading dialog while processing booking request
  void _showLoadingDialog(BuildContext context) =>
      AppAlerts.showLoadingDialog(context);

  /// Handle successful appointment booking
  ///
  /// After successful booking:
  /// 1. Dismiss loading dialog
  /// 2. Route to appropriate payment gateway based on selected method
  void _handleSuccessfulAppointment(
    BuildContext context,
    BookAppointmentActionState state,
  ) {
    // Dismiss loading dialog
    AppRouter.pop(context);
    // Route to appropriate payment gateway
    _navigateToPaymentGateway(context, state.selectedPaymentMethod);
  }

  /// Route to appropriate payment gateway based on selected payment method
  ///
  /// Each payment method has its dedicated screen and different processing:
  /// - Paymob: For mobile wallet or card payments
  /// - Stripe: For international card payments
  /// - PayPal: For PayPal account payments
  void _navigateToPaymentGateway(
    BuildContext context,
    PaymentGatewaysTypes paymentMethod,
  ) {
    switch (paymentMethod) {
      case PaymentGatewaysTypes.paymobMobileWallets:
      case PaymentGatewaysTypes.paymobCard:
        _navigateToPaymobPayment(context, paymentMethod);
        break;
      case PaymentGatewaysTypes.stripe:
        _navigateToStripePayment(context);
        break;
      case PaymentGatewaysTypes.payPal:
        _navigateToPaypalPayment(context);
        break;
      case PaymentGatewaysTypes.none:
        break;
    }
  }

  /// Route to Paymob payment screen
  ///
  /// Paymob supports two payment methods:
  /// - Mobile Wallets (Mobile wallet payments)
  /// - Card Payment (Card payments)
  void _navigateToPaymobPayment(
    BuildContext context,
    PaymentGatewaysTypes paymentMethod,
  ) {
    _resetAppointmentState(context);
    AppRouter.push(
      context,
      PaymobPaymentScreen(
        selectedPaymentMethod: paymentMethod,
        phoneNumber: formControllers.phoneNumberController.text,
      ),
      onResult: (value) => _handlePaymentResult(context, value),
    );
  }

  /// Route to PayPal payment screen
  void _navigateToPaypalPayment(BuildContext context) {
    _resetAppointmentState(context);
    AppRouter.push(
      context,
      const PaypalPaymentScreen(),
      onResult: (value) => _handlePaymentResult(context, value),
    );
  }

  /// Route to Stripe payment screen
  void _navigateToStripePayment(BuildContext context) {
    _resetAppointmentState(context);
    AppRouter.push(
      context,
      const StripePaymentScreen(),
      onResult: (value) => _handlePaymentResult(context, value),
    );
  }

  /// Process payment result from different gateways and handle navigation back
  ///
  /// This method is called when returning from payment gateway screens.
  /// It handles different payment outcomes and manages the user flow:
  ///
  /// - Payment cancellation: User manually cancelled the payment process
  /// - Payment failure: Payment was attempted but failed (insufficient funds, etc.)
  /// - Other errors: Unexpected errors during payment processing
  ///
  /// Important: This processing only occurs when there's an error in payment
  /// processing, causing the user to return to this screen (PatientDetailsScreen
  /// with PaymentProcessingButton) instead of completing the successful flow.
  ///
  /// Flow Details:
  /// 1. User completes patient details and selects payment method
  /// 2. Navigates to external payment gateway (Paymob/Stripe/PayPal)
  /// 3. If payment fails or is cancelled, returns to this screen
  /// 4. This method displays appropriate error messages to the user
  /// 5. User remains on PatientDetailsScreen to retry or correct information
  ///
  /// Note: Successful payments complete the flow and don't return to this screen
  void _handlePaymentResult(BuildContext context, dynamic result) {
    if (result == null) return;

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!context.mounted) return;

      switch (result) {
        case AppStrings.paymentCancelledError:
          _showPaymentCancelledAlert(context);
          break;
        case AppStrings.paymentFailedError:
          _showPaymentFailedDialog(context);
          break;
        default:
          _showGenericErrorDialog(context, result.toString());
          break;
      }
    });
  }

  /// Show payment cancellation alert
  void _showPaymentCancelledAlert(BuildContext context) =>
      AppAlerts.showTopSnackBarAlert(
        context: context,
        msg: AppStrings.paymentCancelledMsg,
        backgroundColor: Colors.orange,
        icon: Icons.error_outline_sharp,
      );

  /// Show payment failure dialog
  void _showPaymentFailedDialog(BuildContext context) =>
      AppAlerts.showErrorDialog(context, AppStrings.paymentFailedDescription);

  /// Show generic error dialog
  void _showGenericErrorDialog(BuildContext context, String error) =>
      AppAlerts.showErrorDialog(context, error);

  /// Reset booking state to start fresh
  void _resetAppointmentState(BuildContext context) =>
      context.read<AppointmentCubit>().resetBookAppointmentState();

  /// Handle appointment booking errors
  ///
  /// When booking fails:
  /// 1. Show error message to user
  /// 2. Reset booking state
  void _handleAppointmentError(
    BuildContext context,
    BookAppointmentActionState state,
  ) {
    Future.microtask(() {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        AppAlerts.showCustomErrorDialog(
          context,
          state.bookAppointmentErrorMessage,
        );
      });

      if (context.mounted) {
        _resetAppointmentState(context);
      }
    });
  }
}
