import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';

import '../../../../../core/enum/appointment_status.dart';
import '../custom_widgets/completed_appointment_actions.dart';
import 'upcoming_appointment_actions.dart';

class AppointmentActions extends StatelessWidget {
  final AppointmentStatus appointmentStatus;
  final ClientAppointmentsEntity appointment;

  const AppointmentActions({
    super.key,
    required this.appointmentStatus,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return switch (appointmentStatus) {
      AppointmentStatus.confirmed => UpcomingAppointmentActions(
        appointment: appointment,
      ),
      AppointmentStatus.completed => CompletedAppointmentActions(
        appointment: appointment,
      ),

      AppointmentStatus.cancelled ||
      AppointmentStatus.pendingPayment => const SizedBox.shrink(),
    };
  }
}
