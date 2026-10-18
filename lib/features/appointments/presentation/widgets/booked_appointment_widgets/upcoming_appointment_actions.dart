import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/widgets/booked_appointment_widgets/reschedule_appointment_button.dart';

import 'cancel_appointment_button.dart';

class UpcomingAppointmentActions extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const UpcomingAppointmentActions({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CancelAppointmentButton(
          doctorId: appointment.doctorId,
          appointmentId: appointment.appointmentId,
        ),
        RescheduleAppointmentButton(appointment: appointment),
      ],
    );
  }
}
