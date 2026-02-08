import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart'
    show CompletedAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/completed_appointments_state.dart'
    show CompletedAppointmentsState;
import 'package:medora/features/appointments/presentation/screens/appointment_details_screen.dart'
    show AppointmentDetailsScreen;
import 'package:medora/features/shared/presentation/screens/pagination_screen_mixin.dart'
    show PaginationScreenMixin;

import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';

class CompletedAppointmentsList extends StatefulWidget {
  const CompletedAppointmentsList({super.key});

  @override
  State<CompletedAppointmentsList> createState() =>
      _CompletedAppointmentsListState();
}

class _CompletedAppointmentsListState extends State<CompletedAppointmentsList>
    with
        PaginationScreenMixin<
          ClientAppointmentsEntity,
          CompletedAppointmentsState,
          CompletedAppointmentsCubit,
          CompletedAppointmentsList
        >,
        AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget buildDataCard(ClientAppointmentsEntity appointment, int index) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              AppointmentDetailsScreen(appointment: appointment),
        ),
      ),
      child: AppointmentCard(
        appointmentStatus: AppointmentStatus.completed,
        appointment: appointment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CompletedAppointmentsCubit, CompletedAppointmentsState>(
      builder: (context, state) {
        return buildPaginationBody(context, state);
      },
    );
  }
}
