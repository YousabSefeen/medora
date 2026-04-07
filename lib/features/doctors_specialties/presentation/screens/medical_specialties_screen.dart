import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/app_view_context.dart' show AppViewContext;
import 'package:medora/features/doctors_specialties/presentation/widgets/doctor_specialties_section.dart'
    show MedicalSpecialtyData;
import 'package:medora/features/doctors_specialties/presentation/widgets/specialty_card_item.dart'
    show SpecialtyCardItem;

class MedicalSpecialtiesScreen extends StatelessWidget {
  const MedicalSpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      appBar: AppBar(
        title: const Text(AppStrings.medicalSpecialties),
        backgroundColor: AppColors.customWhite,
      ),
      body: SafeArea(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          gridDelegate: _buildGridDelegate(),
          itemCount: MedicalSpecialtyData.specialties.length,
          itemBuilder: (context, index) => SpecialtyCardItem(
            viewContext: AppViewContext.medicalSpecialties,
            specialty: MedicalSpecialtyData.specialties[index],
          ),
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _buildGridDelegate() =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 150,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      );
}
