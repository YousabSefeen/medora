import 'package:flutter/material.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/medical_specialties_section.dart'
    show MedicalSpecialtiesSection;

import '../../../../core/constants/app_strings/app_strings.dart';
import 'form_title.dart';

class MedicalSpecialtiesField extends StatelessWidget {
  const MedicalSpecialtiesField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(label: AppStrings.medicalSpecialtiesLabel),
        MedicalSpecialtiesSection(),
      ],
    );
  }
}
