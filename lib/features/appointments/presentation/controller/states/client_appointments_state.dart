//
//
// import 'package:equatable/equatable.dart' show Equatable;
// import 'package:medora/core/enum/appointment_status.dart' show AppointmentStatus;
// import 'package:medora/core/enum/request_state.dart' show RequestState;
// import 'package:medora/core/utils/date_time_formatter.dart' show DateTimeFormatter;
// import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
//
// class ClientAppointmentsState extends Equatable {
//   final List<ClientAppointmentsEntity> appointments;
//   final RequestState state;
//   final String error;
//
//   const ClientAppointmentsState({
//     this.appointments = const [],
//     this.state = RequestState.loading,
//     this.error = '',
//   });
//
//   List<ClientAppointmentsEntity> get upcomingAppointments {
//     final now = DateTime.now();
//     return appointments
//         .where((appointment) =>
//     appointment.appointmentStatus == AppointmentStatus.confirmed.name &&
//         _appointDateFormatted(appointment.appointmentDate).isAfter(now))
//         .toList();
//   }
//
//   List<ClientAppointmentsEntity> get completedAppointments {
//     final now = DateTime.now();
//     return appointments
//         .where((appointment) =>
//     appointment.appointmentStatus == AppointmentStatus.completed.name ||
//         (appointment.appointmentStatus == AppointmentStatus.confirmed.name &&
//             _appointDateFormatted(appointment.appointmentDate).isBefore(now)))
//         .toList();
//   }
//
//   List<ClientAppointmentsEntity> get cancelledAppointments {
//     return appointments
//         .where((appointment) =>
//     appointment.appointmentStatus == AppointmentStatus.cancelled.name)
//         .toList();
//   }
//
//   DateTime _appointDateFormatted(String appointDate) {
//     return DateTimeFormatter.convertDateToString(appointDate);
//   }
//
//   ClientAppointmentsState copyWith({
//     List<ClientAppointmentsEntity>? appointments,
//     RequestState? state,
//     String? error,
//   }) {
//     return ClientAppointmentsState(
//       appointments: appointments ?? this.appointments,
//       state: state ?? this.state,
//       error: error ?? this.error,
//     );
//   }
//
//   @override
//   List<Object?> get props => [appointments, state, error];
// }
//
//
