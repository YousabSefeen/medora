import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/doctor_info_variant.dart'
    show DoctorInfoVariant;
import 'package:medora/core/extensions/string_extensions.dart';

class DoctorInfoFooter extends StatelessWidget {
  final DoctorInfoVariant variant;

  final int fee;
  final String location;

  const DoctorInfoFooter({
    super.key,
    this.variant = DoctorInfoVariant.card,
    required this.fee,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _IconLabelValue(
            icon: FontAwesomeIcons.locationDot,
            iconColor: AppColors.red,
            label: AppStrings.locationLabel,
            value: location.toCapitalizeFirstLetter(),
          ),
        ),
        Expanded(
          child: _IconLabelValue(
            icon: FontAwesomeIcons.dollarSign,
            iconColor: Colors.black54,
            label: AppStrings.feeLable,
            value: '$fee ${AppStrings.egyptianCurrency}',
          ),
        ),

        Visibility(
          visible: variant == DoctorInfoVariant.details,
          child: const Expanded(
            child: _IconLabelValue(
              icon: FontAwesomeIcons.clockRotateLeft,
              iconColor: Colors.black54,
              label: AppStrings.waitingTime,
              value: AppStrings.min_15,
            ),
          ),
        ),
      ],
    );
  }
}

class _IconLabelValue extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _IconLabelValue({
    super.key,

    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, color: iconColor, size: 14.sp),
        const SizedBox(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.mediumPlaypenBold.copyWith(fontSize: 12.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: textTheme.smallSoftBlueMedium,
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
