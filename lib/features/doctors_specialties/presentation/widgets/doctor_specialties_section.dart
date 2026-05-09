import 'package:flutter/material.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/doctors_specialties/data/models/medical_specialty.dart'
    show MedicalSpecialty;
import 'package:medora/features/doctors_specialties/presentation/widgets/specialty_card_item.dart'
    show SpecialtyCardItem;
import 'package:medora/generated/assets.dart' show Assets;

class DoctorSpecialtiesSection extends StatelessWidget {
  const DoctorSpecialtiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.screenHeight * 0.13,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => SpecialtyCardItem(
            specialty: MedicalSpecialtyData.specialties[index],
          ),
        ),
      ),
    );
  }
}

/// Data provider for medical specialties
abstract class MedicalSpecialtyData {
  static final List<MedicalSpecialty> specialties = [
    // 1. التخصصات الأكثر طلباً (Primary Care & Most Common)
    MedicalSpecialty(
      image: Assets.specialtiesGeneralPractice,
      name: 'General Practice',
    ),
    // طبيب عام/أسرة
    MedicalSpecialty(image: Assets.specialtiesDentistry, name: 'Dentistry'),
    // أسنان
    MedicalSpecialty(image: Assets.specialtiesPediatrics, name: 'Pediatrics'),
    // أطفال
    MedicalSpecialty(image: Assets.specialtiesDermatology, name: 'Dermatology'),
    // جلدية
    MedicalSpecialty(
      image: Assets.specialtiesObstetricsAndGynecology,
      name: 'Obstetrics and Gynecology',
    ),
    // نساء وتوليد

    // 2. تخصصات متوسطة الطلب (Popular Specialties)
    MedicalSpecialty(
      image: Assets.specialtiesOphthalmology,
      name: 'Ophthalmology',
    ),
    // رمد/عيون
    MedicalSpecialty(image: Assets.specialtiesOrthopedics, name: 'Orthopedics'),
    // عظام
    MedicalSpecialty(image: Assets.specialtiesOtolaryngology, name: 'ENT'),
    // أنف وأذن وحنجرة
    MedicalSpecialty(image: Assets.specialtiesCardiology, name: 'Cardiology'),
    // قلب

    // 3. تخصصات محددة (Specific & Long-term Care)
    MedicalSpecialty(image: Assets.specialtiesPsychiatry, name: 'Psychiatry'),
    // طب نفسي
    MedicalSpecialty(image: Assets.specialtiesNeurology, name: 'Neurology'),
    // مخ وأعصاب
    MedicalSpecialty(
      image: Assets.specialtiesGastroenterology,
      name: 'Gastroenterology',
    ),
    // جهاز هضمي
    MedicalSpecialty(
      image: Assets.specialtiesEndocrinology,
      name: 'Endocrinology',
    ),
    // غدد وسكري
    MedicalSpecialty(image: Assets.specialtiesUrology, name: 'Urology'),
    // مسالك بولية
    MedicalSpecialty(
      image: Assets.specialtiesPhysicalTherapy,
      name: 'Physical Therapy',
    ),
    // علاج طبيعي
    MedicalSpecialty(image: Assets.specialtiesNutrition, name: 'Nutrition'),
    // تغذية
  ];
}
