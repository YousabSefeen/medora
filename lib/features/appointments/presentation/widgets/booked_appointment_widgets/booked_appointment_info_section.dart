import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/string_extensions.dart';

import '../../../../../core/enum/appointment_status.dart';
import '../icon_with_text.dart';

class BookedAppointmentInfoSection extends StatelessWidget {
  final String appointmentDate;
  final String appointmentTime;
  final AppointmentStatus appointmentStatus;

  const BookedAppointmentInfoSection({
    super.key,
    required this.appointmentStatus,

    required this.appointmentDate,
    required this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    final dateTimeBlackStyle = Theme.of(context).textTheme.dateTimeBlackStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateInfo(dateTimeBlackStyle),
        _buildTimeInfo(dateTimeBlackStyle),
        _buildStatusInfo(dateTimeBlackStyle),
      ],
    );
  }

  Widget _buildDateInfo(TextStyle textStyle) => IconWithText(
    icon: Icons.calendar_month,
    text: appointmentDate,
    textStyle: textStyle,
  );

  Widget _buildTimeInfo(TextStyle textStyle) => IconWithText(
    icon: Icons.alarm,
    text: appointmentTime,
    textStyle: textStyle,
  );

  Widget _buildStatusInfo(TextStyle textStyle) => IconWithText(
    icon: Icons.circle_rounded,
    iconColor: _getIconColor(),
    text: appointmentStatus.name.toCapitalizeFirstLetter(),
    textStyle: textStyle.copyWith(
      letterSpacing: 1,
      fontWeight: FontWeight.w700,
      color: _getIconColor(),
    ),
  );

  Color _getIconColor() {
    switch (appointmentStatus) {
      case AppointmentStatus.confirmed:
        return AppColors.greenLight;
      case AppointmentStatus.completed:
        return AppColors.lightBlue;
      case AppointmentStatus.cancelled:
      case AppointmentStatus.pendingPayment:
        return const Color(0xFFF44336);
    }
  }
}
