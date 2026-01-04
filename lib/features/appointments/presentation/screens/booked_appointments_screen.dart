import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/loading_list.dart'
    show LoadingList;
import 'package:medora/features/appointments/presentation/controller/cubit/fetch_client_appointments_cubit.dart'
    show FetchClientAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/fetch_client_appointments_state.dart'
    show FetchClientAppointmentsState;

import '../../../../core/constants/common_widgets/custom_error_widget.dart';
import '../../../../core/enum/request_state.dart';
import '../widgets/booked_appointments_list.dart';

class BookedAppointmentsScreen extends StatefulWidget {
  const BookedAppointmentsScreen({super.key});

  @override
  State<BookedAppointmentsScreen> createState() =>
      _BookedAppointmentsScreenState();
}

class _BookedAppointmentsScreenState extends State<BookedAppointmentsScreen> {
  @override
  void initState() {
    super.initState();

    context
        .read<FetchClientAppointmentsCubit>()
        .fetchClientAppointmentsWithDoctorDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FetchClientAppointmentsCubit,
      FetchClientAppointmentsState
    >(
      builder: (context, state) {
        switch (state.requestState) {
          case RequestState.initial:
          case RequestState.loading:
            return const LoadingList(height: 100);
          case RequestState.loaded:
            return BookedAppointmentsList(
              upcomingAppointmentsList: state.upcomingAppointments,
              completedAppointmentsList: state.completedAppointments,
              cancelledAppointmentsList: state.cancelledAppointments,
            );

          case RequestState.error:
            return CustomErrorWidget(errorMessage: state.failureMessage);
        }
      },
    );
  }
}
