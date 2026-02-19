import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_avatar.dart'
    show DoctorAvatar;

class DoctorInfo extends StatelessWidget {
  final String heroTag;
  final String doctorImage;
  final String doctorName;

  const DoctorInfo({
    super.key,
    required this.heroTag,
    required this.doctorImage,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 25,
      children: [
        DoctorAvatar(heroTag: heroTag, imageUrl: doctorImage, size: 60),

        Expanded(
          child: Text(
            '${AppStrings.dR} $doctorName',
            style: Theme.of(
              context,
            ).textTheme.largeBlackBold.copyWith(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
