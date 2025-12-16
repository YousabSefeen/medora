import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/presentation/view_data/doctor_time_slots_view_data.dart' show DoctorTimeSlotsViewData;

import 'package:medora/features/appointments/presentation/widgets/time_slots_grid.dart'
    show TimeSlotsGrid;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/constants/themes/app_text_styles.dart';

import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';

class TimeSlotsDisplaySection extends StatelessWidget {
  const TimeSlotsDisplaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState, DoctorTimeSlotsViewData>(
      selector: _mapStateToData,
      builder: (context, data) {
        return data.availableSlots.isEmpty
            ? const ContentUnavailableWidget(
                isExpandedHeight: false,
                description: AppStrings.noAppointmentsAvailableToday,
              )
            : _TimeSlotsWithTitle(data: data);
      },
    );
  }

  DoctorTimeSlotsViewData _mapStateToData(AppointmentState state) {
    return DoctorTimeSlotsViewData(
      selectedSlot: state.selectedTimeSlot,
      availableSlots: state.availableDoctorTimeSlots,
    );
  }
}

class _TimeSlotsWithTitle extends StatelessWidget {
  final DoctorTimeSlotsViewData data;

  const _TimeSlotsWithTitle({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(AppStrings.selectTime, style: Theme.of(context).textTheme.mediumBlackBold),
        const SizedBox(height: 20),
        TimeSlotsGrid(data: data),
      ],
    );
  }
}
