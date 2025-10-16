import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class CriteriaFilterIcon extends StatelessWidget {
  final bool isSearchingByCriteria;
  final VoidCallback onPressed;

  const CriteriaFilterIcon({
    super.key,
    required this.onPressed,
    required this.isSearchingByCriteria,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buildButtonStyle(),
      child: FaIcon(
        FontAwesomeIcons.sliders,
        color: _getIconColor(),
        size: 18.sp,
      ),
    );
  }

  ButtonStyle _buildButtonStyle() => ButtonStyle(
    padding: WidgetStateProperty.all(EdgeInsets.zero),
    backgroundColor: WidgetStateProperty.all(_getBackgroundColor()),
    elevation: WidgetStateProperty.all(1),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: AppColors.fieldBorderColor),
      ),
    ),
    minimumSize: WidgetStateProperty.all(const Size(50, 40)),
  );

  Color _getBackgroundColor() =>
      isSearchingByCriteria ? AppColors.softBlue : AppColors.fieldFillColor;

  Color _getIconColor() =>
      isSearchingByCriteria ? AppColors.white : Colors.black54;
}
