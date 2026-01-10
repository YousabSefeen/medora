import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/custom_error_widget.dart'
    show CustomErrorWidget;
import 'package:medora/core/constants/common_widgets/loading_list.dart'
    show LoadingList;
import 'package:medora/core/enum/request_state.dart';
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;

import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';
import '../screens/appointment_details_screen.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsList extends StatelessWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<UpcomingAppointmentsCubit>()
            ..fetchUpcomingAppointments(),
      child: BlocBuilder<UpcomingAppointmentsCubit, UpcomingAppointmentsState>(
        builder: (context, state) {
          switch (state.requestState) {
            case RequestState.initial:
            case RequestState.loading:
              return const LoadingList(height: 100);
            case RequestState.loaded:
              return _buildAppointmentCard(state.upcomingAppointments);
            case RequestState.error:
              return CustomErrorWidget(errorMessage: state.failureMessage);
          }
        },
      ),
    );
  }

  Widget _buildAppointmentCard(
    List<ClientAppointmentsEntity>? upcomingAppointmentsList,
  ) {
    return upcomingAppointmentsList!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyUpcomingAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: upcomingAppointmentsList.length,
            itemBuilder: (context, index) {
              final ClientAppointmentsEntity appointment =
                  upcomingAppointmentsList[index];
              return GestureDetector(
                onTap: () =>
                    _navigateToAppointmentDetails(context, appointment),

                child: AppointmentCard(
                  appointmentStatus: AppointmentStatus.confirmed,
                  appointment: appointment,
                ),
              );
            },
          );
  }

  void _navigateToAppointmentDetails(
    BuildContext context,
    ClientAppointmentsEntity appointment,
  ) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) =>
          AppointmentDetailsScreen(appointment: appointment),
    ),
  );
}
