import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;
import 'package:medora/core/constants/common_widgets/custom_error_widget.dart'
    show CustomErrorWidget;
import 'package:medora/core/constants/common_widgets/loading_list.dart'
    show LoadingList;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart'
    show CancelledAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/cancelled_appointments_state.dart'
    show CancelledAppointmentsState;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';

class CancelledAppointmentsList extends StatelessWidget {
  const CancelledAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<CancelledAppointmentsCubit>()
            ..fetchCancelledAppointments(),

      child:
          BlocBuilder<CancelledAppointmentsCubit, CancelledAppointmentsState>(
            builder: (context, state) {
              switch (state.requestState) {
                case RequestState.initial:
                case RequestState.loading:
                  return const LoadingList(height: 100);
                case RequestState.loaded:
                  return _buildAppointmentCard(state.cancelledAppointments);
                case RequestState.error:
                  return CustomErrorWidget(errorMessage: state.failureMessage);
              }
            },
          ),
    );
  }

  StatelessWidget _buildAppointmentCard(
    List<ClientAppointmentsEntity>? cancelledAppointments,
  ) {
    return cancelledAppointments!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyUpcomingAppointmentsMessage,
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
