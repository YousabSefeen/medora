import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart' show TimeSlotCubit;
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart' show TimeSlotState;
import 'package:medora/features/appointments/presentation/widgets/time_slots_loader_section.dart'
    show TimeSlotsLoaderSection;

import '../../../../core/enum/appointment_availability_status.dart';

import 'doctor_not_available_message.dart';

class AppointmentTimeSelector extends StatelessWidget {
  const AppointmentTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
        TimeSlotCubit,
        TimeSlotState,
      AppointmentAvailabilityStatus
    >(
      selector: (state) => state.availabilityStatus,
      builder: (context, status) {
        if (status == AppointmentAvailabilityStatus.available) {
          return const TimeSlotsLoaderSection();
        }

        return DoctorNotAvailableMessage(appointmentAvailabilityStatus: status);
      },
    );
  }
}
