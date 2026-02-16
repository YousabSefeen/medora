import 'package:flutter/material.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/doctors_specialties/data/models/medical_specialty.dart'
    show MedicalSpecialty;
import 'package:medora/features/doctors_specialties/presentation/widgets/specialty_card_item.dart'
    show SpecialtyCard, SpecialtyCardItem;
import 'package:medora/generated/assets.dart' show Assets;

class DoctorSpecialtiesSection extends StatelessWidget {
  const DoctorSpecialtiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
          height: context.screenHeight * 0.13,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:  MedicalSpecialtyData.specialties.length,
        itemBuilder: (context, index) =>
            SpecialtyCardItem(specialty:  MedicalSpecialtyData.specialties[index]),
      ),
    )
    );
  }
}




/// Data provider for medical specialties
abstract class MedicalSpecialtyData {
  static final List<MedicalSpecialty> specialties = [
    MedicalSpecialty(
      image: Assets.imagesGeneralPractice,
      name: 'General Practice',
    ),
    MedicalSpecialty(image: Assets.imagesDentistry, name: 'Dentistry'),
    MedicalSpecialty(image: Assets.imagesDermatology, name: 'Dermatology'),
    MedicalSpecialty(image: Assets.imagesPediatrics, name: 'Pediatrics'),
    MedicalSpecialty(image: Assets.imagesOphthalmology, name: 'Ophthalmology'),
    MedicalSpecialty(
      image: Assets.imagesObstetricsAndGynecology,
      name: 'Obstetrics and Gynecology',
    ),
  ];
}



