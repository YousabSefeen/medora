import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../core/constants/common_widgets/custom_shimmer.dart';
import '../../../../generated/assets.dart';
import '../../../doctor_profile/data/models/doctor_model.dart';

class DoctorProfileHeader extends StatelessWidget {
  final DoctorModel doctorInfo;

  const DoctorProfileHeader({super.key, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          _doctorImage(),
          _doctorInfo(context),
        ],
      )
    );
  }

  ClipRRect _doctorImage() {
    final imageSize = 55.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10000.0),
      child: CachedNetworkImage(
        imageUrl: doctorInfo.imageUrl,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.fill,
        placeholder: (context, _) => SizedBox(
          child: CustomShimmer(height: imageSize, width: imageSize),
        ),
        errorWidget: (context, _, __) => Image.asset(
          Assets.imagesErrorImage,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Expanded _doctorInfo(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              doctorInfo.name,
              style: Theme.of(context).textTheme.mediumBlack.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
              ),
            ),
            Text(doctorInfo.bio,
                style: Theme.of(context)
                    .listTileTheme
                    .subtitleTextStyle!
                    .copyWith(
                        fontSize: 14.sp,
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      );
}
