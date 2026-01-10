import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/custom_error_widget.dart'
    show CustomErrorWidget;
import 'package:medora/core/constants/common_widgets/loading_list.dart'
    show LoadingList;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart'
    show CompletedAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/completed_appointments_state.dart'
    show CompletedAppointmentsState;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';

class CompletedAppointmentsList extends StatelessWidget {
  const CompletedAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<CompletedAppointmentsCubit>()
            ..fetchCompletedAppointments(),
      child:
          BlocBuilder<CompletedAppointmentsCubit, CompletedAppointmentsState>(
            builder: (context, state) {
              switch (state.requestState) {
                case RequestState.initial:
                case RequestState.loading:
                  return const LoadingList(height: 100);
                case RequestState.loaded:
                  return _buildAppointmentCard(state.completedAppointments);
                case RequestState.error:
                  return CustomErrorWidget(errorMessage: state.failureMessage);
              }
            },
          ),
    );
  }

  Widget _buildAppointmentCard(
    List<ClientAppointmentsEntity>? completedAppointmentsList,
  ) {
    return completedAppointmentsList!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyCompletedAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: completedAppointmentsList.length,
            itemBuilder: (context, index) => AppointmentCard(
              appointmentStatus: AppointmentStatus.completed,
              appointment: completedAppointmentsList[index],
            ),
          );
  }
}
