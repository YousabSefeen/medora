import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/widgets/booked_appointment_widgets/appointment_reschedule_button.dart'
    show AppointmentRescheduleButton;

import '../../../data/models/client_appointments_model.dart';
import 'cancel_button.dart';

class UpcomingAppointmentActionsSection extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const UpcomingAppointmentActionsSection({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CancelButton(appointment: appointment),
          AppointmentRescheduleButton(appointment: appointment),
        ],
      ),
    );
  }
}
