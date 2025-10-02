import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/app_strings/appointment_status_strings.dart';
import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';
import '../controller/cubit/appointment_cubit.dart';
import 'appointment_card.dart';

class CompletedAppointmentsList extends StatelessWidget {
  const CompletedAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final completedAppointments =
        context.read<AppointmentCubit>().completedAppointments;
    return completedAppointments!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyCompletedAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: completedAppointments.length,
            itemBuilder: (context, index) => AppointmentCard(
              appointmentStatus: AppointmentStatus.completed,
              appointment: completedAppointments[index],
            ),
          );
  }
}
