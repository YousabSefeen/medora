import 'package:flutter/material.dart';
import 'package:medora/features/doctor_list/presentation/screen/doctor_list_view_screen.dart' show DoctorListViewScreen;
import 'package:medora/features/doctors_specialties/presentation/widgets/doctor_specialties_section.dart' show DoctorSpecialtiesSection;
import 'package:medora/features/home/presentation/widgets/home_sliver_app_bar.dart' show HomeSliverAppBar;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    const CustomScrollView (
      physics:BouncingScrollPhysics(),
      slivers: [
        HomeSliverAppBar(),
        SliverToBoxAdapter(
          child: DoctorSpecialtiesSection(),
        ),
        DoctorListViewScreen(),
      ],
    );
  }
}

