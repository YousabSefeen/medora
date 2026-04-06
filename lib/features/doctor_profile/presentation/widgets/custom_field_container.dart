import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/common_widgets/field_error_text.dart'
    show FieldErrorText;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class CustomFieldContainer extends StatelessWidget {
  final Widget child;
  final FormFieldState<Object?> field;

  const CustomFieldContainer({
    super.key,
    required this.child,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.fieldFillColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: field.hasError ? Colors.red : AppColors.fieldBorderColor,
              width: 1.2,
            ),
          ),
          child: child,
        ),
        field.hasError
            ? FieldErrorText(errorText: field.errorText!)
            : const SizedBox.shrink(),
      ],
    );
  }
}
