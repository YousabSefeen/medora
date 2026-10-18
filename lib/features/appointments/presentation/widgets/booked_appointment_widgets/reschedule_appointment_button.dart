import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';

import 'appointment_reschedule_sheet.dart';

class RescheduleAppointmentButton extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const RescheduleAppointmentButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: const WidgetStatePropertyAll(AppColors.softBlue),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
      ),
      onPressed: () => AppointmentRescheduleSheet.show(context, appointment),
      child: const Text(AppStrings.reschedule),
    );
  }
}

