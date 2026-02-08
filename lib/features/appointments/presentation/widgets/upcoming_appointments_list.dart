import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;
import 'package:medora/features/appointments/presentation/screens/appointment_details_screen.dart'
    show AppointmentDetailsScreen;
import 'package:medora/features/shared/presentation/screens/pagination_screen_mixin.dart'
    show PaginationScreenMixin;

import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsList extends StatefulWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  State<UpcomingAppointmentsList> createState() =>
      _UpcomingAppointmentsListState();
}

class _UpcomingAppointmentsListState extends State<UpcomingAppointmentsList>
    with
        PaginationScreenMixin<
          ClientAppointmentsEntity,
          UpcomingAppointmentsState,
          UpcomingAppointmentsCubit,
          UpcomingAppointmentsList
        >,
        AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;



  @override
  Widget buildDataCard(ClientAppointmentsEntity appointment,int index) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              AppointmentDetailsScreen(appointment: appointment),
        ),
      ),
      child: AppointmentCard(
        appointmentStatus: AppointmentStatus.confirmed,
        appointment: appointment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UpcomingAppointmentsCubit, UpcomingAppointmentsState>(
      builder: (context, state) {
        return buildPaginationBody(context, state);
      },
    );
  }
}
