import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_validator.dart'
    show DoctorFieldsValidator;
import 'package:medora/features/doctor_profile/presentation/widgets/custom_selection_container.dart'
    show CustomSelectionContainer;
import 'package:medora/features/doctor_profile/presentation/widgets/days_sheet_button.dart'
    show DaysSheetButton;

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';

class WorkingDaysSection extends StatelessWidget {
  const WorkingDaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
      selector: (state) => state.confirmedDays,
      builder: (context, days) {
        final hasNoDaysSelected = days.isEmpty;

        return FormField<List<String>>(
          validator: (_) =>
              DoctorFieldsValidator().validateWorkingDays(hasNoDaysSelected),
          builder: (field) {
            return CustomSelectionContainer(
              isSpecialtiesField: false,
              isEmptySelection: hasNoDaysSelected,
              selectedItems: days,
              field: field,
              placeholderText: AppStrings.workingDaysHint,
              selectionButton: const DaysSheetButton(),
            );
          },
        );
      },
    );
  }
}
