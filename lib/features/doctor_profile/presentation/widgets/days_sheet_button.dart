import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart'
    show DoctorProfileCubit;
import 'package:medora/features/doctor_profile/presentation/widgets/custom_confirm_button.dart'
    show CustomConfirmButton;
import 'package:medora/features/doctor_profile/presentation/widgets/working_days_list_view_selector.dart'
    show WorkingDaysListViewSelector;

import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/circular_dropdown_icon.dart';

class DaysSheetButton extends StatelessWidget {
  const DaysSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => IconButton(
        icon: const CircularDropdownIcon(),
        onPressed: () => _handleDaySelectionPress(context, isKeyboardVisible),
      ),
    );
  }

  void _handleDaySelectionPress(BuildContext context, bool isKeyboardVisible) {
    if (isKeyboardVisible) {
      _dismissKeyboardAndShowDaySheet(context);
    } else {
      _showDaySelectionBottomSheet(context);
    }
  }

  void _dismissKeyboardAndShowDaySheet(BuildContext context) {
    AppRouter.dismissKeyboard();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        _showDaySelectionBottomSheet(context);
      }
    });
  }

  void _showDaySelectionBottomSheet(BuildContext context) {
    _syncTempDaysFromConfirmed(context);
    _displayDaySelectionSheet(context);
  }

  void _syncTempDaysFromConfirmed(BuildContext context) =>
      context.read<DoctorProfileCubit>().syncTempDaysFromConfirmed();

  void _displayDaySelectionSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,
        appBarBackgroundColor: AppColors.customWhite,
        appBarTitle: AppStrings.workingDaysDialogTitle,
        appBarTitleColor: AppColors.black,
        stickyActionBar: _buildConfirmationButton(context),
        body: const WorkingDaysListViewSelector(),
      );

  Widget _buildConfirmationButton(BuildContext context) => CustomConfirmButton(
    onPressed: () => _confirmAndCloseDaySelection(context),
  );

  void _confirmAndCloseDaySelection(BuildContext context) {
    context.read<DoctorProfileCubit>().confirmWorkingDaysSelection();
    AppRouter.popWithKeyboardDismiss(context);
  }
}
