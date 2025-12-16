import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;

import '../../../../../core/enum/appointment_status.dart';
import '../../../data/models/client_appointments_model.dart';
import '../icon_with_text.dart';

class BookedAppointmentInfoSection extends StatelessWidget {
  final AppointmentStatus appointmentStatus;
  final ClientAppointmentsEntity appointment;

  const BookedAppointmentInfoSection({
    super.key,
    required this.appointmentStatus,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final dateTimeBlackStyle = Theme.of(context).textTheme.dateTimeBlackStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateInfo(dateTimeBlackStyle),
        _buildTimeInfo(dateTimeBlackStyle),
        _buildStatusInfo(dateTimeBlackStyle, appointmentStatus),
      ],
    );
  }

  Widget _buildDateInfo(TextStyle textStyle) => IconWithText(
    icon: Icons.calendar_month,
    text: appointment.appointmentDate,
    textStyle: textStyle,
  );

  Widget _buildTimeInfo(TextStyle textStyle) => IconWithText(
    icon: Icons.alarm,
    text: appointment.appointmentTime,
    textStyle: textStyle,
  );

  Widget _buildStatusInfo(
    TextStyle textStyle,
    AppointmentStatus appointmentStatus,
  ) => IconWithText(
    icon: Icons.circle_rounded,
    iconColor: _getIconColor(appointmentStatus),
    text: appointment.appointmentStatus.capitalizeFirstLetter(),
    //    textStyle: textStyle,
    textStyle: textStyle.copyWith(
      letterSpacing: 1,
      fontWeight: FontWeight.w700,
      color: _getIconColor(appointmentStatus),
    ),
  );

  _getIconColor(AppointmentStatus appointmentStatus) {
    switch (appointmentStatus) {
      case AppointmentStatus.confirmed:
        return const Color(0xFFFFC107);

      case AppointmentStatus.completed:
        return const Color(0xFF4CAF50);
      case AppointmentStatus.cancelled:
        return const Color(0xFFF44336);
    }
  }
}
