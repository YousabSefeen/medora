import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/custom_field_container.dart' show CustomFieldContainer;
import 'package:medora/features/doctor_profile/presentation/widgets/specialties_sheet_button.dart' show SpecialtiesSheetButton;

class SelectedSpecialtiesContainer extends StatelessWidget {
  final bool isSpecialtiesEmpty;
  final List<String> confirmedSpecialties;
  final FormFieldState<List<String>> field;

  const SelectedSpecialtiesContainer({
    super.key,
    required this.isSpecialtiesEmpty,
    required this.confirmedSpecialties,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFieldContainer(
      field: field,
      child: Row(
        crossAxisAlignment: isSpecialtiesEmpty
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: isSpecialtiesEmpty
                ? _buildHintText(context)
                : _buildSpecialtiesWrap(context),
          ),
          const SpecialtiesSheetButton(),
        ],
      ),
    );
  }

  /// Build  the hint text when no specialty are selected.
  Widget _buildHintText(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      AppStrings.specialtiesHint,
      style: Theme.of(context).textTheme.hintFieldStyle,
    ),
  );

  /// Build  a Wrap of confirmed selected specialty.
  Widget _buildSpecialtiesWrap(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
      confirmedSpecialties.map((specialty) => _buildSpecialtyChip(context, specialty)).toList(),
    );
  }

  /// Build  an individual chip for a selected specialty.
  Widget _buildSpecialtyChip(BuildContext context, String specialty) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.green,
      borderRadius: BorderRadius.circular(50.r),
    ),
    child: Text(
      specialty,
      style: Theme.of(context).textTheme.mediumBlack.copyWith(
        color: Colors.white,
        fontSize: 14.sp,
      ),
    ),
  );
}
