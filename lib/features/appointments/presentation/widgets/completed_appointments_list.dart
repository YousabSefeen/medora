import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/extensions/appointment_filter.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/states/completed_appointments_state.dart';
import 'package:medora/features/shared/presentation/screens/pagination_screen_mixin.dart';

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
      onTap: () =>
          context.push(AppRouterNames.appointmentDetails, extra: appointment),
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
      buildWhen: (previous, current) =>
          previous.requestState != current.requestState ||
          previous.isLoadingMore,
      builder: (context, state) => buildPaginationBody(
        appointmentFilter: AppointmentFilter.completed,
        context: context,
        state: state,
      ),
    );
  }
}
