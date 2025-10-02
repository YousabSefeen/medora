import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/doctors_specialties/data/models/medical_specialty.dart' show MedicalSpecialty;
import 'package:medora/features/doctors_specialties/presentation/screens/specialty_doctors_screen.dart' show SpecialtyDoctorsScreen;
import 'package:medora/features/doctors_specialties/presentation/widgets/specialty_card.dart' show SpecialtyCard;
import 'package:medora/generated/assets.dart' show Assets;

class DoctorSpecialtiesSection extends StatelessWidget {
  const DoctorSpecialtiesSection({super.key});

  static final List<MedicalSpecialty> medicalSpecialties = [
    MedicalSpecialty(
        image: Assets.imagesGeneralPractice, name: 'General Practice'),
    MedicalSpecialty(image: Assets.imagesDentistry, name: 'Dentistry'),
    MedicalSpecialty(image: Assets.imagesDermatology, name: 'Dermatology'),
    MedicalSpecialty(image: Assets.imagesPediatrics, name: 'Pediatrics'),
    MedicalSpecialty(
        image: Assets.imagesOphthalmology, name: 'Ophthalmology'),
    MedicalSpecialty(
        image: Assets.imagesObstetricsAndGynecology,
        name: 'Obstetrics and Gynecology'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          _buildHeaderSection(context),
          _buildSpecialtiesListView(context),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Doctor Specialties',
          style:GoogleFonts.playpenSans(
            fontSize: 16.sp,
            color: AppColors.softBlue,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        Text(
          'See All',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildSpecialtiesListView(BuildContext context) {
    return SizedBox(
       height: MediaQuery.sizeOf(context).height*0.13,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: medicalSpecialties.length,
        itemBuilder: (context, index) => SpecialtyCard(

          specialtyName: medicalSpecialties[index].name,
          imagePath: medicalSpecialties[index].image,
          onTap: (){
            print('DoctorSpecialtiesSection.xxxxxxxxxxxxx ${medicalSpecialties[index].name}');

           AppRouter.push(context, SpecialtyDoctorsScreen(specialtyName: medicalSpecialties[index].name,));
          },
        ),
      ),
    );
  }

}


