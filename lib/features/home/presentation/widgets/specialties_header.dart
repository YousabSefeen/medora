import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/doctor_profile/presentation/widgets/section_title.dart'
    show SectionTitle;
import 'package:medora/features/home/presentation/widgets/view_all_specialties.dart'
    show ViewAllSpecialties;

class SpecialtiesHeader extends StatelessWidget {
  const SpecialtiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 5),
        child: Row(
          children: [
            SectionTitle(title: AppStrings.doctorSpecialties),
            Spacer(),
            ViewAllSpecialties(),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
