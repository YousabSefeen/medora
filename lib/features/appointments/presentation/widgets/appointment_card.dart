import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;

import '../../../../core/enum/appointment_status.dart';
import 'booked_appointment_widgets/booked_appointment_footer.dart';
import 'booked_appointment_widgets/booked_appointment_header.dart';

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
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 1,
      shape: _buildRoundedRectangleBorder(),
      child: Column(
        children: [
          BookedAppointmentHeader(doctorModel: appointment.doctorEntity),
          _buildDivider(),
          BookedAppointmentFooter(
            appointmentStatus: appointmentStatus,
            appointment: appointment,
          ),
        ],
      ),
    );
  }

  RoundedRectangleBorder _buildRoundedRectangleBorder() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Colors.black12),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Divider(color: Colors.black12, height: 1.7),
    );
  }
}
