import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/enum/appointment_availability_status.dart';
import 'package:medora/features/appointments/presentation/constants/empty_state_config.dart';
import 'package:medora/features/appointments/presentation/widgets/generic_empty_state.dart';
import 'package:medora/generated/assets.dart';

class EmptyBookingState extends StatelessWidget {
  final AppointmentAvailabilityStatus stateType;

  const EmptyBookingState({super.key, required this.stateType});

  @override
  Widget build(BuildContext context) {
    final (title, subtitle) = _getBookingMessages();

    return GenericEmptyState(
      config: EmptyStateConfig.booking,
      lottiePath: _getLottiePath(),
      title: title,
      subtitle: subtitle,
    );
  }

  /// Maps booking state types to their messages using a clean switch expression.
  (String title, String subtitle) _getBookingMessages() {
    return switch (stateType) {
      AppointmentAvailabilityStatus.fullyBooked => (
        AppStrings.fullyBookedTitle,
        AppStrings.fullyBookedSubtitle,
      ),
      AppointmentAvailabilityStatus.notWorkingDay => (
        AppStrings.notWorkingDayTitle,
        AppStrings.notWorkingDaySubtitle,
      ),
      AppointmentAvailabilityStatus.pastDate => (
        AppStrings.pastDateTitle,
        AppStrings.pastDateSubtitle,
      ),

      AppointmentAvailabilityStatus.available => throw StateError(
        'Invalid Code Path: Empty booking UI messages should never be requested when the status is "available".',
      ),
    };
  }

  /// Centralized lottie path management for booking empty states.
  String _getLottiePath() {
    return switch (stateType) {
      AppointmentAvailabilityStatus.fullyBooked =>
        Assets.lottie.emptyListLarge,

      AppointmentAvailabilityStatus.pastDate ||
      AppointmentAvailabilityStatus.notWorkingDay =>
        Assets.lottie.xMarker,

      AppointmentAvailabilityStatus.available => throw StateError(
        'Invalid Code Path: Empty booking Lottie path should never be requested when the status is "available".',
      ),
    };
  }
}
