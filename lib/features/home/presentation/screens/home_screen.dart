import 'package:flutter/material.dart';
import 'package:medora/features/doctor_list/presentation/screen/popular_doctors_section.dart'
    show PopularDoctorsSection;
import 'package:medora/features/doctors_specialties/presentation/widgets/doctor_specialties_section.dart'
    show DoctorSpecialtiesSection;
import 'package:medora/features/home/presentation/constants/home_constants.dart'
    show HomeConstants;
import 'package:medora/features/home/presentation/widgets/home_sliver_app_bar.dart'
    show HomeSliverAppBar;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // Keyboard locks when scrolling
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      key: const PageStorageKey<String>('home_screen'),

      physics: const BouncingScrollPhysics(),
      slivers: [
        const HomeSliverAppBar(),
        SliverPadding(
          padding: HomeConstants.homeBodyPadding,
          sliver: const SliverToBoxAdapter(child: DoctorSpecialtiesSection()),
        ),

        SliverConstrainedCrossAxis(
          maxExtent: MediaQuery.sizeOf(context).width*0.95,
          sliver: SliverPadding(
            padding: HomeConstants.homeBodyPadding,
            sliver: const PopularDoctorsSection(),
          ),
        ),
      ],
    );
  }
}
