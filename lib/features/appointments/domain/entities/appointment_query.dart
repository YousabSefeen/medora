// lib/features/appointments/domain/entities/appointment_query.dart
import 'package:flutter/material.dart' show DateTimeRange;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart' show PaginationParameters;

class AppointmentQuery {
  final AppointmentType type;
  final PaginationParameters parameters;
  final DateTimeRange? dateRange;
  final String? doctorId;

  const AppointmentQuery({
    required this.type,
    required this.parameters,
    this.dateRange,
    this.doctorId,
  });
}

enum AppointmentType {
  upcoming,
  completed,
  cancelled,
}