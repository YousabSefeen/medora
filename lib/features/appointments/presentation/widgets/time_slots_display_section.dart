import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart'
    show TimeSlotCubit;
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart'
    show TimeSlotState;
import 'package:medora/features/appointments/presentation/data/time_slot_data.dart' show TimeSlotData;

import 'package:medora/features/appointments/presentation/widgets/time_slots_grid.dart'
    show TimeSlotsGrid;

class TimeSlotsDisplaySection extends StatelessWidget {
  const TimeSlotsDisplaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TimeSlotCubit, TimeSlotState,  TimeSlotData>(
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

  TimeSlotData _mapStateToData(TimeSlotState state) {
    return TimeSlotData(
      selectedSlot: state.selectedTimeSlot,
      availableSlots: state.availableDoctorTimeSlots,
    );
  }
}

class _TimeSlotsWithTitle extends StatelessWidget {
  final TimeSlotData data;

  const _TimeSlotsWithTitle({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          AppStrings.selectTime,
          style: Theme.of(context).textTheme.mediumBlackBold,
        ),
        const SizedBox(height: 20),
        TimeSlotsGrid(timeSlotData: data),
      ],
    );
  }
}
