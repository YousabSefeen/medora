import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        backgroundColor: WidgetStateProperty.all(AppColors.fieldFillColor),
        elevation: WidgetStateProperty.all(1),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.fieldBorderColor),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(50, 50)),
      ),
      onPressed: onPressed,
      child: const FaIcon(
        FontAwesomeIcons.sliders,
        color: Colors.black54,
        size: 18,
      ),
    );
  }
}