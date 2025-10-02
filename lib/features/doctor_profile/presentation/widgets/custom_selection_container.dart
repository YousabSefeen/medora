import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/custom_field_container.dart' show CustomFieldContainer;


class CustomSelectionContainer extends StatelessWidget {
  final bool isSpecialtiesField;
  final bool isEmptySelection;
  final List<String> selectedItems;
  final FormFieldState<List<String>> field;
  final String placeholderText;
  final Widget selectionButton;

  const CustomSelectionContainer({
    super.key,
    required this.isSpecialtiesField,
    required this.isEmptySelection,
    required this.selectedItems,
    required this.field,
    required this.placeholderText,
    required this.selectionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFieldContainer(
            field: field,
            child: Row(
              crossAxisAlignment: isEmptySelection
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isEmptySelection
                      ? _buildPlaceholderText(context, placeholderText)
                      : _buildSelectedItemsWrap(
                          context,
                          isSpecialtiesField: isSpecialtiesField,
                          selectedItems: selectedItems,
                        ),
                ),
                selectionButton,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderText(BuildContext context, String placeholder) =>
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          placeholder,
          style: Theme.of(context).textTheme.hintFieldStyle,
        ),
      );

  Widget _buildSelectedItemsWrap(
    BuildContext context, {
    required bool isSpecialtiesField,
    required List<String> selectedItems,
  }) =>
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: selectedItems
            .map((item) => _buildGenericChip(
                  context,
                  isSpecialtiesField: isSpecialtiesField,
                  label: item,
                ))
            .toList(),
      );

  Widget _buildGenericChip(
    BuildContext context, {
    required bool isSpecialtiesField,
    required String label,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: isSpecialtiesField
            ? _specialtyChipBoxDecoration()
            : _dayChipBoxDecoration(),
        child: Text(
          label,
          style: Theme.of(context).textTheme.mediumBlack.copyWith(
                color: isSpecialtiesField ? Colors.black : Colors.white,
                fontSize: 14.sp,
              ),
        ),
      );

  BoxDecoration _specialtyChipBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.softBlue),
      );

  BoxDecoration _dayChipBoxDecoration() => BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(50.r),
      );
}
