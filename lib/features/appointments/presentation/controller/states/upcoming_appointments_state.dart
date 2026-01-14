import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/appointment_status.dart'
    show AppointmentStatus;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/utils/date_time_formatter.dart'
    show DateTimeFormatter;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;

class UpcomingAppointmentsState extends Equatable {
  final bool isLoadedBefore;

  final RequestState requestState;
  final String failureMessage;
  final List<ClientAppointmentsEntity> appointments;

  //  fields for Pagination
  final dynamic lastDocument;
  final bool hasMore;
  final bool isLoadingMore;

  const UpcomingAppointmentsState({
    this.isLoadedBefore = false,
    this.requestState = RequestState.loading,
    this.failureMessage = '',
    this.appointments = const [],
    this.lastDocument,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  UpcomingAppointmentsState copyWith({
    bool? isLoadedBefore,
    RequestState? requestState,
    String? failureMessage,
    List<ClientAppointmentsEntity>? appointments,
    dynamic lastDocument,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return UpcomingAppointmentsState(
      isLoadedBefore: isLoadedBefore ?? this.isLoadedBefore,
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      appointments: appointments ?? this.appointments,
      lastDocument: lastDocument ?? this.lastDocument,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  List<ClientAppointmentsEntity> get upcomingAppointments {
    final now = DateTime.now();
    return appointments
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.confirmed.name &&
              _appointDateFormatted(appointment.appointmentDate).isAfter(now),
        )
        .toList();
  }

  DateTime _appointDateFormatted(String appointDate) =>
      DateTimeFormatter.convertDateToString(appointDate);

  @override
  List<Object?> get props => [
    isLoadedBefore,
    requestState,
    failureMessage,
    appointments,
    lastDocument,
    hasMore,
    isLoadingMore,
  ];
}
