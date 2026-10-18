import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/features/home/presentation/widgets/see_all_specialties.dart';
import 'package:medora/features/shared/presentation/widgets/section_title.dart';

class SpecialtiesHeader extends StatelessWidget {
  const SpecialtiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 2),
        child: Row(
          children: [
            SectionTitle(title: AppStrings.exploreSpecialties),
            Spacer(),
            SeeAllSpecialties(),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
