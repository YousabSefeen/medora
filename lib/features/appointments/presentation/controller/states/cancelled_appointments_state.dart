import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/appointment_status.dart'
    show AppointmentStatus;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/utils/date_time_formatter.dart'
    show DateTimeFormatter;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;

class CancelledAppointmentsState extends Equatable {
  final RequestState requestState;
  final String failureMessage;
  final List<ClientAppointmentsEntity> appointments;

  const CancelledAppointmentsState({
    this.requestState = RequestState.loading,
    this.failureMessage = '',
    this.appointments = const [],
  });

  CancelledAppointmentsState copyWith({
    RequestState? requestState,
    String? failureMessage,
    List<ClientAppointmentsEntity>? appointments,
  }) {
    return CancelledAppointmentsState(
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      appointments: appointments ?? this.appointments,
    );
  }





  List<ClientAppointmentsEntity> get cancelledAppointments {
    return appointments
        .where(
          (appointment) =>
      appointment.appointmentStatus == AppointmentStatus.cancelled.name,
    )
        .toList();
  }

  DateTime _appointDateFormatted(String appointDate) =>
      DateTimeFormatter.convertDateToString(appointDate);

  @override
  List<Object?> get props => [requestState, failureMessage, appointments];
}
