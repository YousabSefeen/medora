import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector;
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_errors_strings.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;
import 'package:medora/features/payment_gateways/presentation/controller/cubit/payment_cubit.dart'
    show PaymentCubit;
import 'package:medora/features/payment_gateways/presentation/controller/state/payment_state.dart'
    show PaymentState;

class PayNowButton extends StatelessWidget {
  final TextEditingController phoneNumberController;

  const PayNowButton({super.key, required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PaymentCubit, PaymentState, PaymentGatewaysTypes>(
      selector: (state) => state.selectedPaymentMethod,
      builder: (context, selectedPaymentMethod) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: AdaptiveActionButton(
          title: AppStrings.payNow,
          isEnabled: selectedPaymentMethod != PaymentGatewaysTypes.none,
          isLoading: false,
          onPressed: () =>
              _handlePaymentSelection(context, selectedPaymentMethod),
        ),
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
      _navigateToPaymentGateway(context, selectedPaymentMethod);
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
    _navigateToPaymentGateway(context, selectedPaymentMethod);
  }

  /// Validate phone number format
  ///
  /// Requires phone number to be non-empty and more than 5 digits
  bool _isPhoneNumberValid(String phoneNumber) =>
      phoneNumber.isNotEmpty && phoneNumber.length > 5;

  /// Show phone number validation error message
  void _showPhoneValidationError(BuildContext context) {
    final errorMessage = phoneNumberController.text.isEmpty
        ? AppStrings.phoneNumberHintField
        : AppStrings.invalidPhoneNumber;
    OverlayNotificationService.show(
      context: context,
      message: errorMessage,
      type: SnackBarType.error,
      snackBarBehaviorType: SnackBarBehaviorType.top,
    );
  }

  /// Process booking request and start payment process
  ///
  /// After selecting payment method and validating requirements:
  /// 1. Close payment method selection bottom sheet
  /// 2. Start appointment booking process through AppointmentCubit

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
    final extra = {
      'selectedPaymentMethod': paymentMethod,
      'phoneNumber': phoneNumberController.text.trim(),
    };
    context.push(AppRouterNames.paymobPayment, extra: extra).then((value) {
      if (!context.mounted || value == null) return;
      _handlePaymentResult(context, value);
    });
  }

  /// Route to PayPal payment screen
  void _navigateToPaypalPayment(BuildContext context) {
    context.push(AppRouterNames.paypalPayment).then((value) {
      if (!context.mounted || value == null) return;
      _handlePaymentResult(context, value);
    });
  }

  /// Route to Stripe payment screen
  void _navigateToStripePayment(BuildContext context) {
    context.push(AppRouterNames.stripePayment).then((value) {
      if (!context.mounted || value == null) return;
      _handlePaymentResult(context, value);
    });
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
        case AppErrorsStrings.paymentCanceled:
          _showPaymentCancelledAlert(context);
          break;
        case AppErrorsStrings.paymentFailedError:
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
      OverlayNotificationService.show(
        context: context,
        message: AppErrorsStrings.paymentCanceled,
        type: SnackBarType.warning,
        snackBarBehaviorType: SnackBarBehaviorType.top,
        duration: AppDurations.seconds_5,
      );

  /// Show payment failure dialog
  void _showPaymentFailedDialog(BuildContext context) =>
      AppAlerts.showCustomErrorDialog(
        context,
        AppErrorsStrings.paymentFailedDescription,
      );

  /// Show generic error dialog
  void _showGenericErrorDialog(BuildContext context, String error) =>
      AppAlerts.showCustomErrorDialog(context, error);
}
