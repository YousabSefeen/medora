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
      image: Assets.images.specialties.generalPractice.path,
      name: 'General Practice',
    ),
    // طبيب عام/أسرة
    MedicalSpecialty(image:  Assets.images.specialties.dentistry.path, name: 'Dentistry'),
    // أسنان
    MedicalSpecialty(image: Assets.images.specialties.pediatrics.path,  name: 'Pediatrics'),
    // أطفال
    MedicalSpecialty(image:  Assets.images.specialties.dermatology.path, name: 'Dermatology'),
    // جلدية
    MedicalSpecialty(
      image:  Assets.images.specialties.obstetricsAndGynecology.path,
      name: 'Obstetrics and Gynecology',
    ),
    // نساء وتوليد

    // 2. تخصصات متوسطة الطلب (Popular Specialties)
    MedicalSpecialty(
      image:  Assets.images.specialties.ophthalmology.path,
      name: 'Ophthalmology',
    ),
    // رمد/عيون
    MedicalSpecialty(image:  Assets.images.specialties.orthopedics.path, name: 'Orthopedics'),
    // عظام
    MedicalSpecialty(image:  Assets.images.specialties.otolaryngology.path, name: 'ENT'),
    // أنف وأذن وحنجرة
    MedicalSpecialty(image:  Assets.images.specialties.cardiology.path, name: 'Cardiology'),
    // قلب

    // 3. تخصصات محددة (Specific & Long-term Care)
    MedicalSpecialty(image:  Assets.images.specialties.psychiatry.path, name: 'Psychiatry'),
    // طب نفسي
    MedicalSpecialty(image: Assets.images.specialties.neurology.path, name: 'Neurology'),
    // مخ وأعصاب
    MedicalSpecialty(
      image: Assets.images.specialties.gastroenterology.path,
      name: 'Gastroenterology',
    ),
    // جهاز هضمي
    MedicalSpecialty(
      image:  Assets.images.specialties.endocrinology.path,
      name: 'Endocrinology',
    ),
    // غدد وسكري
    MedicalSpecialty(image:  Assets.images.specialties.urology.path, name: 'Urology'),
    // مسالك بولية
    MedicalSpecialty(
      image:  Assets.images.specialties.physicalTherapy.path,
      name: 'Physical Therapy',
    ),
    // علاج طبيعي
    MedicalSpecialty(image:  Assets.images.specialties.nutrition.path,   name: 'Nutrition'),
    // تغذية
  ];
}
