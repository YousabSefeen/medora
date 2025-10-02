import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'custom_confirm_button.dart';
import 'custom_day_checkbox_tile.dart';
/// Bottom sheet that displays a scrollable ListView for selecting working days
///
/// Contains:
/// - ListView.builder with checkboxes for each day of the week
/// - Confirm button to save selections
/// - Managed state through BLoC for temporary day selections
class WorkingDaysListViewSelector extends StatelessWidget {
  const WorkingDaysListViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ConstrainedBox(
      constraints:   BoxConstraints(
        minHeight: screenHeight*0.65,
        maxHeight: screenHeight*0.8,
      ),

      child: BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
        selector: (state) => state.selectedDaysTempList,
        builder: (context, tempDays) => ListView.builder(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 5,
            left: 20,
            right: 40,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: AppStrings.weekDays.length,
          itemBuilder: (context, index) {
            final day = AppStrings.weekDays[index];
            return CustomCheckboxTile(
              title: day,
              isSelected: tempDays.contains(day),
              onChanged: (value) => context.read<DoctorProfileCubit>().toggleWorkingDay(day),
            );
          },
        ),
      ),
    );
  }
}
