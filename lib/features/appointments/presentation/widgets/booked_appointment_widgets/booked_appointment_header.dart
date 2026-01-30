import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/list_string_extension.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/circular_doctor_image.dart' show CircularDoctorImage;

import '../../../../../core/constants/app_strings/app_strings.dart';

class BookedAppointmentHeader extends StatelessWidget {
  final DoctorEntity doctorModel;

  const BookedAppointmentHeader({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
       spacing: 12.w,
        children: [
          CircularDoctorImage(imageUrl: doctorModel.imageUrl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 4.h,
              children: [
                _buildDoctorName(context),
                _buildDoctorSpecialties(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorName(BuildContext context) {
    return Text(
      '${AppStrings.dR} ${doctorModel.name}',
      style: Theme.of(context).textTheme.largeBlackBold,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDoctorSpecialties(BuildContext context) {
    return Text(
      doctorModel.specialties.buildJoin(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).listTileTheme.subtitleTextStyle!.copyWith(fontSize: 13.sp),
    );
  }


}
