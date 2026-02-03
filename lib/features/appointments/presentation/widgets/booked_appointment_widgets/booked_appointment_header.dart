import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/circular_doctor_image.dart'
    show CircularDoctorImage;
import 'package:medora/features/shared/presentation/widgets/doctor_name.dart'
    show DoctorName;
import 'package:medora/features/shared/presentation/widgets/doctor_specialties.dart'
    show DoctorSpecialties;

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

              children: [
                DoctorName(name: doctorModel.name),
                DoctorSpecialties(specialties: doctorModel.specialties),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
