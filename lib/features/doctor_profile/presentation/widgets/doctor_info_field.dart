import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_borders/app_borders.dart'
    show AppBorders;
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

  final double? textHeight;

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

    this.textHeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? FormTitle(label: label!) : const SizedBox.shrink(),
        TextFormField(
          style: textTheme.styleInputField.copyWith(height: textHeight),
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
            border: AppBorders.inputEnabledBorder,
            enabledBorder: AppBorders.inputEnabledBorder,
            focusedBorder: AppBorders.inputFocusedBorder,
            errorBorder: AppBorders.inputErrorBorder,
            errorStyle: textTheme.styleInputFieldError,
          ),
        ),
      ],
    );
  }
}
