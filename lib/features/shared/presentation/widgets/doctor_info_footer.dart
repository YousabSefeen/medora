import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/doctor_info_variant.dart'
    show DoctorInfoVariant;
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class DoctorInfoFooter extends StatelessWidget {
  final DoctorInfoVariant variant;

  final int fee;
  final String location;
  final double iconSize;
  final double textSize;

  const DoctorInfoFooter({
    super.key,
    this.variant = DoctorInfoVariant.card,
    required this.fee,
    required this.location,
    required this.iconSize,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoRowItem(
            icon: FontAwesomeIcons.locationDot,
            iconColor: AppColors.red,
            label: AppStrings.locationLabel,
            value: location.toCapitalizeFirstLetter(),
            iconSize: iconSize,
            textSize: textSize,
          ),
        ),
        Expanded(
          child: _InfoRowItem(
            icon: FontAwesomeIcons.dollarSign,
            iconColor: Colors.black54,
            label: AppStrings.feeLable,
            value: '$fee ${AppStrings.egyptianCurrency}',
            iconSize: iconSize,
            textSize: textSize,
          ),
        ),

        Visibility(
          visible: variant == DoctorInfoVariant.details,
          child: Expanded(
            child: _InfoRowItem(
              icon: FontAwesomeIcons.clockRotateLeft,
              iconColor: Colors.black54,
              label: AppStrings.waitingTime,
              value: AppStrings.min_15,
              iconSize: iconSize,
              textSize: textSize,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRowItem extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final String label;

  final String value;
  final double textSize;

  const _InfoRowItem({
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.label,

    required this.value,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, color: iconColor, size: iconSize),
        const SizedBox(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textTheme.mediumPlaypenBold.copyWith(
                  fontSize: textSize,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: context.textTheme.smallSoftBlueMedium.copyWith(
                  fontSize: textSize,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
