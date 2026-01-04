import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;

import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;
import 'package:medora/features/payment_gateways/paymob/presentation/view/screens/paymob_payment_screen.dart'
    show PaymobPaymentScreen;
import 'package:medora/features/payment_gateways/paypal/presentation/views/screens/paypal_payment_screen.dart'
    show PaypalPaymentScreen;
import 'package:medora/features/payment_gateways/presentation/controller/cubit/payment_cubit.dart' show PaymentCubit;
import 'package:medora/features/payment_gateways/presentation/controller/state/payment_state.dart' show PaymentState;
import 'package:medora/features/payment_gateways/stripe/presentation/View/Screens/stripe_payment_screen.dart'
    show StripePaymentScreen;

class PayNowButton extends StatelessWidget {
  final TextEditingController phoneNumberController;

  const PayNowButton({super.key, required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
        PaymentCubit,
        PaymentState,
      PaymentGatewaysTypes
    >(
      selector: (state) => state.selectedPaymentMethod,
      builder: (context, selectedPaymentMethod) => AdaptiveActionButton(
        title: AppStrings.payNow,
        isEnabled: selectedPaymentMethod != PaymentGatewaysTypes.none,
        isLoading: false,
        onPressed: () =>
            _handlePaymentSelection(context, selectedPaymentMethod),
      ),
    );
  }

  /// Handle payment method selection and requirement validation
  ///
  /// For Paymob Mobile Wallets, requires phone number validation
  /// before proceeding to booking process
  void _handlePaymentSelection(
    BuildContext context,
    PaymentGatewaysTypes selectedPaymentMethod,
  ) {
    if (selectedPaymentMethod == PaymentGatewaysTypes.paymobMobileWallets) {
      _validateAndProcessPaymobPayment(context, selectedPaymentMethod);
    } else {
      _processAppointmentRequest(context, selectedPaymentMethod);
    }
  }

  /// Validate phone number for Paymob Mobile Wallets payment method
  ///
  /// Paymob Mobile Wallets requires a valid phone number for wallet linking
  void _validateAndProcessPaymobPayment(
    BuildContext context,
    PaymentGatewaysTypes selectedPaymentMethod,
  ) {
    if (!_isPhoneNumberValid(phoneNumberController.text)) {
      _showPhoneValidationError(context);
      return;
    }
    _processAppointmentRequest(context, selectedPaymentMethod);
  }

  /// Validate phone number format
  ///
  /// Requires phone number to be non-empty and more than 5 digits
  bool _isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty && phoneNumber.length > 5;
  }

  /// Show phone number validation error message
  void _showPhoneValidationError(BuildContext context) {
    final errorMessage = phoneNumberController.text.isEmpty
        ? 'Please enter your phone number'
        : 'Invalid phone number';

    AppAlerts.showTopSnackBarAlert(
      context: context,
      msg: errorMessage,
      backgroundColor: AppColors.red,
      icon: FontAwesomeIcons.xmark,
    );
  }

  /// Process booking request and start payment process
  ///
  /// After selecting payment method and validating requirements:
  /// 1. Close payment method selection bottom sheet
  /// 2. Start appointment booking process through AppointmentCubit
  void _processAppointmentRequest(
    BuildContext context,
    PaymentGatewaysTypes selectedPaymentMethod,
  ) {
    // Close payment method selection bottom sheet
  ///  AppRouter.pop(context);
    // Start appointment booking and payment pذrocess
    //xxxxxxxxxxxxxx
    // context.read<BookAppointmentCubit>().handleSubmitAppointmentRequest(
    //   phoneNumber: formControllers.phoneNumberController.text.trim(),
    //   controllers: formControllers,
    // );
    _navigateToPaymentGateway(context, selectedPaymentMethod);
  }

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
    //xxxx _resetAppointmentState(context);
    AppRouter.push(
      context,
      PaymobPaymentScreen(
        selectedPaymentMethod: paymentMethod,
        phoneNumber: phoneNumberController.text,
      ),
      onResult: (value) {
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        _handlePaymentResult(context, value);
      },
    );
  }

  /// Route to PayPal payment screen
  void _navigateToPaypalPayment(BuildContext context) {
    //xxxx _resetAppointmentState(context);
    AppRouter.push(
      context,
      const PaypalPaymentScreen(),
      onResult: (value) => _handlePaymentResult(context, value),
    );
  }

  /// Route to Stripe payment screen
  void _navigateToStripePayment(BuildContext context) {
    //xxxx _resetAppointmentState(context);
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
}
