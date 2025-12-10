import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';

class SpecialtiesSheetHeader extends StatelessWidget {
  final String lastSearchTerm;
  final void Function(String) onChanged;

  const SpecialtiesSheetHeader({
    super.key,
    required this.onChanged,
    required this.lastSearchTerm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          _specialtySearchField(context, onChanged),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Expanded _specialtySearchField(
    BuildContext context,
    void Function(String) onChanged,
  ) => Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        child: TextFormField(
          style: Theme.of(
            context,
          ).textTheme.styleInputField.copyWith(fontWeight: FontWeight.w400),
          controller: TextEditingController(text: lastSearchTerm),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: AppStrings.doctorSpecialtyHintSearchField,
            hintStyle: Theme.of(
              context,
            ).textTheme.hintFieldStyle.copyWith(color: Colors.grey.shade600),
            fillColor: AppColors.customWhite,
            filled: true,
            border: _buildBorder(Colors.black12),
            enabledBorder: _buildBorder(AppColors.softBlue),
            focusedBorder: _buildBorder(AppColors.softBlue),
            errorBorder: _buildBorder(Colors.red),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    ),
  );

  OutlineInputBorder _buildBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: color, width: 1.2),
  );
}
