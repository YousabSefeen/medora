import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/controller/cubit/fetch_client_appointments_cubit.dart' show FetchClientAppointmentsCubit;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';

import 'appointment_card.dart';

class CompletedAppointmentsList extends StatelessWidget {
  final List<ClientAppointmentsEntity>? completedAppointmentsList;
  const CompletedAppointmentsList({super.key,required this.completedAppointmentsList});

  @override
  Widget build(BuildContext context) {

    return completedAppointmentsList!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyCompletedAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: completedAppointmentsList!.length,
            itemBuilder: (context, index) => AppointmentCard(
              appointmentStatus: AppointmentStatus.completed,
              appointment: completedAppointmentsList![index],
            ),
          );
  }
}
