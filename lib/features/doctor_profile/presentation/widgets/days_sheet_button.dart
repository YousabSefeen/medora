import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/custom_confirm_button.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/selection_sheet_button.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/working_days_list_view_selector.dart';

import '../../../../core/constants/app_strings/app_strings.dart';

class DaysSheetButton extends StatelessWidget {
  const DaysSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorProfileCubit>();

    return SelectionSheetButton(
      onInit: () => cubit.syncTempDaysFromConfirmed(),
      sheetBuilder: (sheetContext) {
        AppAlerts.showCustomBottomSheet(
          context: sheetContext,
          appBarBackgroundColor: AppColors.customWhite,
          appBarTitle: AppStrings.workingDaysDialogTitle,
          appBarTitleColor: AppColors.black,
          stickyActionBar: CustomConfirmButton(
            onPressed: () {
              cubit.confirmWorkingDaysSelection();
              sheetContext.pop();
            },
          ),
          body: BlocProvider.value(
            value: cubit,
            child: const WorkingDaysListViewSelector(),
          ),
        );
        return const SizedBox.shrink();
      },
    );
  }
}
