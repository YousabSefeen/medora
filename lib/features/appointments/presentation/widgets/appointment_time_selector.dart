import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/presentation/widgets/time_slots_loader_section.dart'
    show TimeSlotsLoaderSection;

import '../../../../core/enum/appointment_availability_status.dart';
import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';
import 'doctor_not_available_message.dart';

class AppointmentTimeSelector extends StatelessWidget {
  const AppointmentTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AppointmentCubit,
      AppointmentState,
      AppointmentAvailabilityStatus
    >(
      selector: (state) => state.appointmentAvailabilityStatus,
      builder: (context, status) {
        if (status == AppointmentAvailabilityStatus.available) {
          return const TimeSlotsLoaderSection();
        }

        return DoctorNotAvailableMessage(appointmentAvailabilityStatus: status);
      },
    );
  }
}
