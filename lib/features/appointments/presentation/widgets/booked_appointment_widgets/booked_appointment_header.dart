import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/list_string_extension.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../doctor_profile/data/models/doctor_model.dart';




class BookedAppointmentHeader extends StatelessWidget {
  final DoctorModel doctorModel;
  const BookedAppointmentHeader({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _buildDoctorImage(doctorModel.imageUrl),
      title: _buildDoctorName(context),
      subtitle: _buildDoctorSpecialties(context),
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
      style: Theme.of(context)
          .listTileTheme
          .subtitleTextStyle!
          .copyWith(fontSize: 13.sp),
    );
  }


  Widget _buildDoctorImage(String imageUrl) {
    return CircleAvatar(
      radius: 40,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
