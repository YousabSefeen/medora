import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/features/shared/presentation/widgets/doctor_avatar.dart'
    show DoctorAvatar;
import 'package:medora/features/shared/presentation/widgets/doctor_name.dart'
    show DoctorName;
import 'package:medora/features/shared/presentation/widgets/doctor_specialties.dart'
    show DoctorSpecialties;

class BookedAppointmentHeader extends StatelessWidget {
  final String heroTag;

  final String imageUrl;
  final String doctorName;
  final List<String> doctorSpecialties;

  const BookedAppointmentHeader({
    super.key,
    required this.heroTag,
    required this.imageUrl,
    required this.doctorName,
    required this.doctorSpecialties,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        spacing: 12.w,
        children: [
          DoctorAvatar(heroTag: heroTag, imageUrl: imageUrl),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                DoctorName(name: doctorName),
                DoctorSpecialties(specialties: doctorSpecialties),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
