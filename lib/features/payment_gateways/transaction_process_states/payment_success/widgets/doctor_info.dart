import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../../core/constants/common_widgets/app_network_image.dart';

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
        AppNetworkImage(
          heroTag: heroTag,
          imageUrl: doctorImage,
          imageRadius: 360,
          height: 50,
          width: 50,
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Colors.white,width: 1.5),
        ),
        Expanded(
          child: Text(
            '${AppStrings.dR} $doctorName',
            style: Theme.of(
              context,
            ).textTheme.largeBlackBold.copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
