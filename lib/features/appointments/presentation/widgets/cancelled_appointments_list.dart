import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/enum/appointment_status.dart';
import '../controller/cubit/appointment_cubit.dart';
import 'appointment_card.dart';

class CancelledAppointmentsList extends StatelessWidget {
  const CancelledAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final cancelledAppointments = context
        .read<AppointmentCubit>()
        .cancelledAppointments;
    return cancelledAppointments!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyCancelledAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: cancelledAppointments.length,
            itemBuilder: (context, index) => AppointmentCard(
              appointmentStatus: AppointmentStatus.cancelled,
              appointment: cancelledAppointments[index],
            ),
          );
  }
}
