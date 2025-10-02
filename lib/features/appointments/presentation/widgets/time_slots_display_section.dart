import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/appointments/presentation/widgets/time_slots_grid.dart' show TimeSlotsGrid;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/constants/themes/app_text_styles.dart';
import '../../data/models/time_slots_data_model.dart';
import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';

class TimeSlotsDisplaySection extends StatelessWidget {
  const TimeSlotsDisplaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState, TimeSlotsDataModel>(
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

  TimeSlotsDataModel _mapStateToData(AppointmentState state) {
    return TimeSlotsDataModel(
      selectedSlot: state.selectedTimeSlot,
      availableSlots: state.availableDoctorTimeSlots,
    );
  }
}

class _TimeSlotsWithTitle extends StatelessWidget {
  final TimeSlotsDataModel data;

  const _TimeSlotsWithTitle({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text('Select Time', style: Theme.of(context).textTheme.mediumBlackBold),
        const SizedBox(height: 20),
        TimeSlotsGrid(data: data),
      ],
    );
  }
}

