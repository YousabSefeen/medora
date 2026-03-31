import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;

import '../../../../../core/enum/appointment_status.dart';
import '../custom_widgets/completed_appointment_footer_actions.dart';
import 'booked_appointment_info_section.dart';
import 'upcoming_appointment_footer_actions.dart';

class BookedAppointmentFooter extends StatelessWidget {
  final AppointmentStatus appointmentStatus;
  final ClientAppointmentsEntity appointment;

  const BookedAppointmentFooter({
    super.key,
    required this.appointmentStatus,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        spacing: 5,
        children: [
          BookedAppointmentInfoSection(
            appointmentDate: appointment.appointmentDate,
            appointmentTime: appointment.appointmentTime,
            appointmentStatus: appointmentStatus,
          ),
          _buildFooterActions(appointmentStatus, appointment),
        ],
      ),
    );
  }

  Widget _buildFooterActions(
    AppointmentStatus appointmentStatus,
    ClientAppointmentsEntity appointment,
  ) {
    if (appointmentStatus == AppointmentStatus.confirmed) {
      return UpcomingAppointmentFooterActions(appointment: appointment);
    } else if (appointmentStatus == AppointmentStatus.completed) {
      return CompletedAppointmentFooterActions(appointment: appointment);
    } else {
      return const SizedBox.shrink();
    }
  }
}
