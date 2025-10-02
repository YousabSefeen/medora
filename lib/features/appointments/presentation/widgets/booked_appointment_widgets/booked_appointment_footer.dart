import 'package:flutter/material.dart';

import '../../../../../core/enum/appointment_status.dart';
import '../../../data/models/client_appointments_model.dart';
import '../custom_widgets/completed_appointment_actions_section.dart';
import 'booked_appointment_actions_section.dart';
import 'booked_appointment_info_section.dart';

class BookedAppointmentFooter extends StatelessWidget {
  final ClientAppointmentsModel appointment;
  final AppointmentStatus appointmentStatus;

  const BookedAppointmentFooter({
    super.key,
    required this.appointment,
    required this.appointmentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        spacing: 5,
        children: [
          BookedAppointmentInfoSection(appointment: appointment,appointmentStatus:appointmentStatus),
          buildBookedAppointmentActionsSection(appointmentStatus,appointment),
        ],
      ),
    );
  }

  Widget buildBookedAppointmentActionsSection(
      AppointmentStatus appointmentStatus,
  ClientAppointmentsModel appointment,

      ) {

    switch (appointmentStatus) {
      case AppointmentStatus.confirmed:
        return BookedAppointmentActionsSection(appointment: appointment);

      case AppointmentStatus.completed:
        return   CompletedAppointmentActionsSection(appointment:appointment);
      case AppointmentStatus.cancelled:
        return const SizedBox.shrink();
    }
  }
}
