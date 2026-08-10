import 'package:flutter/material.dart';

import 'package:medora/core/constants/app_strings/app_strings.dart';

import 'package:medora/core/extensions/appointment_filter.dart';
import 'package:medora/features/appointments/presentation/widgets/generic_empty_state.dart';

import '../../../../generated/assets.dart';

class EmptyAppointmentsState extends StatelessWidget {
  final AppointmentFilter appointmentFilter;

  const EmptyAppointmentsState({super.key, required this.appointmentFilter});

  @override
  Widget build(BuildContext context) {
    final (title, subtitle) = _getAppointmentMessages();

    return GenericEmptyState(
      lottiePath: Assets.lottie.emptyListMain,
      title: title,
      subtitle: subtitle,
    );
  }

  /// Uses Dart records for clean, type-safe message mapping.
  /// Each filter case is explicitly handled, making the code self-documenting.
  (String title, String subtitle) _getAppointmentMessages() {
    return switch (appointmentFilter) {
      AppointmentFilter.upcoming => (
        AppStrings.upcomingTitle,
        AppStrings.upcomingSubtitle,
      ),
      AppointmentFilter.completed => (
        AppStrings.completedTitle,
        AppStrings.completedSubtitle,
      ),
      AppointmentFilter.canceled => (
        AppStrings.canceledTitle,
        AppStrings.canceledSubtitle,
      ),
    };
  }
}
