import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/appointment_status.dart'
    show AppointmentStatus;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/utils/date_time_formatter.dart'
    show DateTimeFormatter;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;

class CompletedAppointmentsState extends Equatable {
  final RequestState requestState;
  final String failureMessage;
  final List<ClientAppointmentsEntity> appointments;

  const CompletedAppointmentsState({
    this.requestState = RequestState.loading,
    this.failureMessage = '',
    this.appointments = const [],
  });

  CompletedAppointmentsState copyWith({
    RequestState? requestState,
    String? failureMessage,
    List<ClientAppointmentsEntity>? appointments,
  }) {
    return CompletedAppointmentsState(
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      appointments: appointments ?? this.appointments,
    );
  }

  List<ClientAppointmentsEntity> get completedAppointments {
    final now = DateTime.now();
    return appointments
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.completed.name ||
              (appointment.appointmentStatus ==
                      AppointmentStatus.confirmed.name &&
                  _appointDateFormatted(
                    appointment.appointmentDate,
                  ).isBefore(now)),
        )
        .toList();
  }

  DateTime _appointDateFormatted(String appointDate) =>
      DateTimeFormatter.convertDateToString(appointDate);

  @override
  List<Object?> get props => [requestState, failureMessage, appointments];
}
