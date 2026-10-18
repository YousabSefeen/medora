import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';

import '../../../../core/constants/common_widgets/app_network_image.dart';
import '../../../../core/constants/themes/app_text_styles.dart';
import '../../../../core/enum/appointment_status.dart';
import '../../../../core/extensions/theme_extension.dart';
import 'booked_appointment_widgets/appointment_actions.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentStatus appointmentStatus;
  final ClientAppointmentsEntity appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.appointmentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left: 8.w),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            bottomLeft: Radius.circular(8.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DoctorHeader(
              appointment: appointment,
              statusColor: statusColor,
              statusName: appointmentStatus.name,
            ),

            SizedBox(height: 12.h),

            _DateTimeBanner(
              date: appointment.appointmentDate,
              time: appointment.appointmentTime,
            ),

            SizedBox(height: 12.h),

            AppointmentActions(
              appointmentStatus: appointmentStatus,
              appointment: appointment,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() => switch (appointmentStatus) {
    AppointmentStatus.confirmed => AppColors.greenLight,
    AppointmentStatus.completed => AppColors.lightBlue,
    AppointmentStatus.cancelled ||
    AppointmentStatus.pendingPayment => AppColors.red,
  };
}

class _DoctorHeader extends StatelessWidget {
  final ClientAppointmentsEntity appointment;
  final Color statusColor;
  final String statusName;

  const _DoctorHeader({
    required this.appointment,
    required this.statusColor,
    required this.statusName,
  });

  @override
  Widget build(BuildContext context) {
    final doctor = appointment.doctorEntity;
    final String specialty = doctor.specialties.isNotEmpty
        ? doctor.specialties.first
        : 'General';

    return Row(
      children: [
        AppNetworkImage(
          heroTag: appointment.appointmentId,
          imageUrl: doctor.imageUrl,
          imageRadius: 360,
          height: 55,
          width: 55,
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Colors.black12),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Dr. ${doctor.name.toCapitalizeFirstLetter()}',
                style: context.textTheme.doctorName,
                maxLines: 1,
              ),
              SizedBox(height: 2.h),
              Text(
                specialty,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.dustyBlue,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 4.w),
        _StatusChip(statusColor: statusColor, statusName: statusName),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final Color statusColor;
  final String statusName;

  const _StatusChip({required this.statusColor, required this.statusName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        statusName.toCapitalizeFirstLetter(),
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: statusColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _DateTimeBanner extends StatelessWidget {
  final String date;
  final String time;

  const _DateTimeBanner({required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.customWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _IconText(icon: Icons.calendar_today_rounded, text: date),
          Container(width: 1, height: 14.h, color: Colors.grey.shade300),
          _IconText(icon: Icons.access_time_rounded, text: time),
        ],
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: AppColors.darkBlue),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.midnightBlue,
          ),
        ),
      ],
    );
  }
}
