import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';

import 'form_title.dart';

class DoctorInfoField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? hintText;

  final FormFieldValidator<String>? validator;
  final bool isDense;
  final void Function(String)? onChanged;

  const DoctorInfoField({
    super.key,
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.hintText,
    this.validator,
    this.isDense = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? FormTitle(label: label!) : const SizedBox(),
        TextFormField(
          style: textTheme.styleInputField,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            isDense: isDense,

            hintText: hintText,
            hintStyle: textTheme.hintFieldStyle,
            fillColor: AppColors.fieldFillColor,
            filled: true,
            border: _buildBorder(AppColors.fieldBorderColor),
            enabledBorder: _buildBorder(AppColors.fieldBorderColor),
            focusedBorder: _buildBorder(AppColors.fieldBorderColor),
            errorBorder: _buildBorder(Colors.red),
            errorStyle: textTheme.styleInputFieldError,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
