import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

import '../../data/models/time_slots_data_model.dart';
import '../controller/cubit/appointment_cubit.dart';
import 'time_slot_item.dart';

class TimeSlotsGrid extends StatelessWidget {
  final TimeSlotsDataModel data;

  const TimeSlotsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _calculateGridHeight(data.availableSlots.length),
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
          itemCount: data.availableSlots.length,
          itemBuilder: (context, index) {
            final time = data.availableSlots[index];
            return TimeSlotItem(
              time: time,
              isSelected: data.selectedSlot == time,
              onTap: () =>
                  context.read<AppointmentCubit>().updateSelectedTimeSlot(time),
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
