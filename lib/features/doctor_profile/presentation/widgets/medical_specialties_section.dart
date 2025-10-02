import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_validator.dart' show DoctorFieldsValidator;
import 'package:medora/features/doctor_profile/presentation/widgets/custom_selection_container.dart' show CustomSelectionContainer;
import 'package:medora/features/doctor_profile/presentation/widgets/specialties_sheet_button.dart' show SpecialtiesSheetButton;

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';

class MedicalSpecialtiesSection extends StatelessWidget {
  const MedicalSpecialtiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
      selector: (state) => state.confirmedSpecialties,
      builder: (context, specialties) {
        final bool hasNoSpecialtiesSelected = specialties.isEmpty;

        return FormField<List<String>>(
          validator: (_) => DoctorFieldsValidator()
              .validateSpecialties(hasNoSpecialtiesSelected),
          builder: (field) => CustomSelectionContainer(
            isSpecialtiesField: true,
            isEmptySelection: hasNoSpecialtiesSelected,
            selectedItems: specialties,
            field: field,
            placeholderText: AppStrings.specialtiesHint,
            selectionButton: const SpecialtiesSheetButton(),
          ),
        );
      },
    );
  }
}
