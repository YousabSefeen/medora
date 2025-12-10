import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function(bool?) onChanged;

  const CustomCheckboxTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      fillColor: WidgetStatePropertyAll(
        isSelected ? Colors.green : Colors.grey.shade50,
      ),
      checkColor: Colors.white,
      side: const BorderSide(color: Colors.black38),
      checkboxScaleFactor: 1.3,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.mediumBlackBold.copyWith(
          letterSpacing: 0.5,
          color: Colors.black87,
        ),
      ),
      value: isSelected,
      onChanged: onChanged,
    );
  }
}
