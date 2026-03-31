import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/widgets/booked_appointment_widgets/appointment_reschedule_button.dart'
    show AppointmentRescheduleButton;

import '../../../data/models/client_appointments_model.dart';
import 'cancel_button.dart';

class UpcomingAppointmentFooterActions extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const UpcomingAppointmentFooterActions({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CancelButton(
            doctorId: appointment.doctorId,
            appointmentId: appointment.appointmentId,
          ),
          AppointmentRescheduleButton(appointment: appointment),
        ],
      ),
    );
  }
}
