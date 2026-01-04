import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/controller/cubit/fetch_client_appointments_cubit.dart' show FetchClientAppointmentsCubit;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/enum/appointment_status.dart';

import 'appointment_card.dart';

class CancelledAppointmentsList extends StatelessWidget {
  final   List<ClientAppointmentsEntity>? cancelledAppointmentsList;
  const CancelledAppointmentsList({super.key, this.cancelledAppointmentsList});

  @override
  Widget build(BuildContext context) {
    final cancelledAppointments = context
        .read<FetchClientAppointmentsCubit>()
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
