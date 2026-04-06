import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;

class FieldErrorText extends StatelessWidget {
  final String errorText;

  const FieldErrorText({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 8),
      child: Text(errorText, style: context.textTheme.errorFieldStyle),
    );
  }
}
