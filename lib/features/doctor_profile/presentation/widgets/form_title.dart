import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';


class FormTitle extends StatelessWidget {
  final String label;

  const FormTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelFieldStyle,
      ),
    );
  }
}
