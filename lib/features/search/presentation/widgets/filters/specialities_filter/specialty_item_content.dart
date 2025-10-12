import 'package:flutter/material.dart';

import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/search/presentation/widgets/filters/specialities_filter/selection_badge.dart'
    show SelectionBadge;

class SpecialtyItemContent extends StatelessWidget {
  final String specialty;
  final bool isSelected;
  final VoidCallback onTap;

  const SpecialtyItemContent({
    super.key,
    required this.specialty,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainContent(context),
        if (isSelected) _buildSelectionIndicator(),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: _buildDecoration(),
        child: _buildSpecialtyText(context),
      ),
    );

  ShapeDecoration _buildDecoration() => ShapeDecoration(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

  Widget _buildSpecialtyText(BuildContext context) => Text(
      specialty,
      style:  Theme.of(context).textTheme.smallBlack,
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
    );


  Widget _buildSelectionIndicator() =>
      const Positioned(top: 2, right: 2, child: SelectionBadge());
}
