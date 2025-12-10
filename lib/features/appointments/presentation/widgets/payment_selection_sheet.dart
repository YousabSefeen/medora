import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart'
    show AppointmentState;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;
import 'package:medora/features/appointments/presentation/widgets/payment_method_list_view.dart'
    show PaymentMethodListView;

/// Bottom sheet for selecting available payment methods
///
/// This screen allows the user to choose their preferred payment method from:
/// - Paymob (Mobile Wallets or Cards)
/// - Stripe (International Cards)
/// - PayPal (PayPal account)
///
/// After selection, the user presses "Pay Now" to start the booking and payment process
class PaymentSelectionSheet extends StatelessWidget {
  final PatientFieldsControllers formControllers;

  const PaymentSelectionSheet({super.key, required this.formControllers});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AppointmentCubit,
      AppointmentState,
      PaymentGatewaysTypes
    >(
      selector: (state) => state.selectedPaymentMethod,
      builder: (context, selectedPaymentMethod) => Column(
        children: [
          PaymentMethodListView(
            phoneNumberController: formControllers.phoneNumberController,
            selectedPaymentMethod: selectedPaymentMethod,
          ),
          _buildPayNowButton(context, selectedPaymentMethod),
        ],
      ),
    );
  }

  /// Build "Pay Now" button that becomes enabled when payment method is selected
  Widget _buildPayNowButton(
    BuildContext context,
    PaymentGatewaysTypes selectedPaymentMethod,
  ) {
    return AdaptiveActionButton(
      title: AppStrings.payNow,
      isEnabled: selectedPaymentMethod != PaymentGatewaysTypes.none,
      isLoading: false,
      onPressed: () => _handlePaymentSelection(context, selectedPaymentMethod),
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
      _validateAndProcessPaymobPayment(context);
    } else {
      _processAppointmentRequest(context);
    }
  }

  /// Validate phone number for Paymob Mobile Wallets payment method
  ///
  /// Paymob Mobile Wallets requires a valid phone number for wallet linking
  void _validateAndProcessPaymobPayment(BuildContext context) {
    if (!_isPhoneNumberValid(formControllers.phoneNumberController.text)) {
      _showPhoneValidationError(context);
      return;
    }
    _processAppointmentRequest(context);
  }

  /// Validate phone number format
  ///
  /// Requires phone number to be non-empty and more than 5 digits
  bool _isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.isNotEmpty && phoneNumber.length > 5;
  }

  /// Show phone number validation error message
  void _showPhoneValidationError(BuildContext context) {
    final errorMessage = formControllers.phoneNumberController.text.isEmpty
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
  void _processAppointmentRequest(BuildContext context) {
    // Close payment method selection bottom sheet
    AppRouter.pop(context);
    // Start appointment booking and payment process
    context.read<AppointmentCubit>().handleSubmitAppointmentRequest(
      phoneNumber: formControllers.phoneNumberController.text.trim(),
      controllers: formControllers,
    );
  }
}
