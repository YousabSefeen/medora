import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/common_widgets/custom_error_widget.dart';
import 'package:medora/core/constants/common_widgets/custom_shimmer.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/appointment_availability_status.dart';
import 'package:medora/core/enum/request_state.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart';
import 'package:medora/features/appointments/presentation/widgets/empty_booking_state.dart';

class AppointmentTimeSelector extends StatelessWidget {
  const AppointmentTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: context.screenHeight * 0.3),
      child: BlocBuilder<TimeSlotCubit, TimeSlotState>(
        buildWhen: (previous, current) =>
            previous.availabilityStatus != current.availabilityStatus ||
            previous.reservedSlotsState != current.reservedSlotsState ||
            previous.selectedTimeSlot != current.selectedTimeSlot ||
            previous.availableDoctorTimeSlots !=
                current.availableDoctorTimeSlots,
        builder: (context, state) {
          switch (state.availabilityStatus) {
            case AppointmentAvailabilityStatus.pastDate:
            case AppointmentAvailabilityStatus.notWorkingDay:
            case AppointmentAvailabilityStatus.fullyBooked:
              return EmptyBookingState(stateType: state.availabilityStatus);
            case AppointmentAvailabilityStatus.available:
              return _buildRequestStateContent(context, state);
          }
        },
      ),
    );
  }

  Widget _buildRequestStateContent(BuildContext context, TimeSlotState state) {
    switch (state.reservedSlotsState) {
      case RequestState.initial:
      case RequestState.loading:
        return CustomShimmer(height: 100.h, width: double.infinity);

      case RequestState.error:
        return CustomErrorWidget(errorMessage: state.reservedSlotsError);

      case RequestState.loaded:
        if (state.availableDoctorTimeSlots.isEmpty) {
          return const EmptyBookingState(
            stateType: AppointmentAvailabilityStatus.fullyBooked,
          );
        }
        return _TimeSlotsContentSection(
          availableSlots: state.availableDoctorTimeSlots,
          selectedSlot: state.selectedTimeSlot,
        );
    }
  }
}

class _TimeSlotsContentSection extends StatelessWidget {
  final List<String> availableSlots;
  final String? selectedSlot;

  const _TimeSlotsContentSection({
    required this.availableSlots,
    required this.selectedSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          AppStrings.chooseTime,
          style: Theme.of(context).textTheme.mediumBlackBold,
        ),
        const SizedBox(height: 20),
        _TimeSlotsGrid(
          availableSlots: availableSlots,
          selectedSlot: selectedSlot,
        ),
      ],
    );
  }
}

class _TimeSlotsGrid extends StatelessWidget {
  final List<String> availableSlots;
  final String? selectedSlot;

  const _TimeSlotsGrid({
    required this.availableSlots,
    required this.selectedSlot,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _calculateGridHeight(availableSlots.length),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 40,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: availableSlots.length,
          itemBuilder: (context, index) {
            final time = availableSlots[index];
            return _TimeSlotItem(
              time: time,
              isSelected: selectedSlot == time,
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

class _TimeSlotItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlotItem({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.softBlue : AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.black26),
        ),
        child: Text(
          time,
          style: context.textTheme.robotoMediumStyle.copyWith(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
