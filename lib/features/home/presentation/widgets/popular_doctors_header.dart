import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/doctor_profile/presentation/widgets/section_title.dart'
    show SectionTitle;

class PopularDoctorsHeader extends StatelessWidget {
  const PopularDoctorsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: SectionTitle(title: AppStrings.popularDoctors),
      ),
    );
  }
}
