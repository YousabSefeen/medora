import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart' show TimeSlotCubit;
import 'package:medora/features/appointments/presentation/data/time_slot_data.dart' show TimeSlotData;


import 'time_slot_item.dart';

class TimeSlotsGrid extends StatelessWidget {
  final TimeSlotData timeSlotData;

  const TimeSlotsGrid({super.key, required this.timeSlotData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _calculateGridHeight(timeSlotData.availableSlots.length),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.customWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 47,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: timeSlotData.availableSlots.length,
          itemBuilder: (context, index) {
            final time = timeSlotData.availableSlots[index];
            return TimeSlotItem(
              time: time,
              isSelected: timeSlotData.selectedSlot == time,
              onTap: () =>
                  context.read<TimeSlotCubit>().updateSelectedTimeSlot(time),
            );
          },
        ),
      ),
    );
  }

  double _calculateGridHeight(int slotCount) {
    const crossAxisCount = 4;
    const itemHeight = 47;
    const spacing = 8;
    const padding = 10;

    final rows = (slotCount / crossAxisCount).ceil();
    return (rows * (itemHeight + spacing) + padding).toDouble();
  }
}
