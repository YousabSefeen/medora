import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/extensions/appointment_filter.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart'
    show CancelledAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/cancelled_appointments_state.dart'
    show CancelledAppointmentsState;
import 'package:medora/features/shared/presentation/screens/pagination_screen_mixin.dart'
    show PaginationScreenMixin;

import '../../../../core/enum/appointment_status.dart';
import 'appointment_card.dart';

class CancelledAppointmentsList extends StatefulWidget {
  const CancelledAppointmentsList({super.key});

  @override
  State<CancelledAppointmentsList> createState() =>
      _CancelledAppointmentsListState();
}

class _CancelledAppointmentsListState extends State<CancelledAppointmentsList>
    with
        PaginationScreenMixin<
          ClientAppointmentsEntity,
          CancelledAppointmentsState,
          CancelledAppointmentsCubit,
          CancelledAppointmentsList
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
        appointmentStatus: AppointmentStatus.cancelled,
        appointment: appointment,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CancelledAppointmentsCubit, CancelledAppointmentsState>(
      buildWhen: (previous, current) =>
          previous.requestState != current.requestState ||
          previous.isLoadingMore != current.isLoadingMore,
      builder: (context, state) => buildPaginationBody(
        appointmentFilter: AppointmentFilter.canceled,
        context: context,
        state: state,
      ),
    );
  }
}
