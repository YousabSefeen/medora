import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/themes/app_colors.dart';

import 'appointment_cancellation_sheet.dart';

class CancelAppointmentButton extends StatelessWidget {
  final String doctorId;
  final String appointmentId;

  const CancelAppointmentButton({
    super.key,
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkBlue,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      onPressed: () => _showCancellationSheet(context),
      child: const Text(AppStrings.cancel),
    );
  }

  void _showCancellationSheet(BuildContext context) {
    AppointmentCancellationSheet.show(
      context: context,
      onConfirm: () => _navigateToCancellationPage(context),
    );
  }

  void _navigateToCancellationPage(BuildContext context) {
    context.push(
      AppRouterNames.appointmentCancellation,
      extra: {
        'doctorId': doctorId,
        'appointmentId': appointmentId,
      },
    );
  }
}