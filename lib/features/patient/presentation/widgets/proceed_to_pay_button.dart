import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/features/appointments/presentation/widgets/payment_selection_sheet.dart'
    show PaymentSelectionSheet;
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart'
    show PatientCubit;
import 'package:medora/features/patient/presentation/widgets/patient_fields_controllers.dart'
    show PatientFieldsControllers;

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart';

// Payment processing button responsible for opening payment method selection screen
// and managing appointment booking state and routing to appropriate payment gateways
///
// This component handles:
// - Opening bottom sheet for payment method selection
// - Managing appointment booking states (loading, success, error)
// - Routing to different payment gateways based on selection

class ProceedToPayButton extends StatelessWidget {
  final PatientFieldsControllers formControllers;

  const ProceedToPayButton({super.key, required this.formControllers});

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.read<PatientCubit>();
    return AdaptiveActionButton(
      title: AppStrings.proceedToPay,
      isEnabled: true,
      isLoading: false,
      onPressed: () {
        patientCubit.changeValidateMode();

        if (!_isFormValid(context, patientCubit, formControllers)) {
          return;
        } else {
          patientCubit.cachePatientData(formControllers: formControllers);
          _openPaymentMethodSelection(context);
        }
      },
    );
  }

  bool _isFormValid(
    BuildContext context,
    PatientCubit patientCubit,
    PatientFieldsControllers controllers,
  ) {
    final isFormFieldsValid =
        controllers.formKey.currentState?.validate() ?? false;
    final isGenderValid = patientCubit.state.genderType != GenderType.init;
    return isFormFieldsValid && isGenderValid;
  }

  /// Open bottom sheet for selecting available payment methods
  ///
  /// This is the first step in the payment process where the user selects
  /// their preferred payment method (Paymob, Stripe, PayPal)
  void _openPaymentMethodSelection(BuildContext context) {
    _dismissKeyboard();
    AppAlerts.showCustomBottomSheet(
      context: context,
      appBarBackgroundColor: AppColors.white,
      appBarTitle: AppStrings.paymentMethod,
      appBarTitleColor: AppColors.black,
      body: const PaymentSelectionSheet(),
    );
  }

  static void _dismissKeyboard() =>
      FocusManager.instance.primaryFocus?.unfocus();
}
