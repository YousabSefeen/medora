import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/loading_list.dart' show LoadingList;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart' show AppointmentCubit;

import '../../../../core/constants/common_widgets/custom_error_widget.dart';
import '../../../../core/enum/request_state.dart';
import '../controller/states/appointment_state.dart';
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

    context.read<AppointmentCubit>().fetchClientAppointmentsWithDoctorDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        switch (state.getClientAppointmentsListState) {
          case RequestState.initial:
          case RequestState.loading:
            return const LoadingList(height: 100);
          case RequestState.loaded:
            return BookedAppointmentsList(
              appointmentsList: state.getClientAppointmentsList,
            );

          case RequestState.error:
            return CustomErrorWidget(
              errorMessage: state.getClientAppointmentsListError,
            );
        }
      },
    );
  }
}
