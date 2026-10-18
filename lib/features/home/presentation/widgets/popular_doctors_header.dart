import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/features/shared/presentation/widgets/section_title.dart';

class PopularDoctorsHeader extends StatelessWidget {
  const PopularDoctorsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SectionTitle(title: AppStrings.popularDoctors),
      ),
    );
  }
}
