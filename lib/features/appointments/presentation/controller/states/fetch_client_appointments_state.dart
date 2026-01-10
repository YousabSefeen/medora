// import 'package:equatable/equatable.dart' show Equatable;
// import 'package:medora/core/enum/appointment_status.dart'
//     show AppointmentStatus;
// import 'package:medora/core/enum/request_state.dart' show RequestState;
// import 'package:medora/core/utils/date_time_formatter.dart'
//     show DateTimeFormatter;
// import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
//     show ClientAppointmentsEntity;
//
// class FetchClientAppointmentsState extends Equatable {
//   final RequestState requestState;
//   final String failureMessage;
//   final List<ClientAppointmentsEntity> clientAppointments;
//
//   const FetchClientAppointmentsState({
//     this.requestState = RequestState.loading,
//     this.failureMessage = '',
//     this.clientAppointments = const [],
//   });
//
//   FetchClientAppointmentsState copyWith({
//     RequestState? requestState,
//     String? failureMessage,
//     List<ClientAppointmentsEntity>? clientAppointments,
//   }) {
//     return FetchClientAppointmentsState(
//       requestState: requestState ?? this.requestState,
//       failureMessage: failureMessage ?? this.failureMessage,
//       clientAppointments: clientAppointments ?? this.clientAppointments,
//     );
//   }
//
//   List<ClientAppointmentsEntity> get upcomingAppointments {
//     final now = DateTime.now();
//     return clientAppointments
//         .where(
//           (appointment) =>
//               appointment.appointmentStatus ==
//                   AppointmentStatus.confirmed.name &&
//               _appointDateFormatted(appointment.appointmentDate).isAfter(now),
//         )
//         .toList();
//   }
//
//   List<ClientAppointmentsEntity> get completedAppointments {
//     final now = DateTime.now();
//     return clientAppointments
//         .where(
//           (appointment) =>
//               appointment.appointmentStatus ==
//                   AppointmentStatus.completed.name ||
//               (appointment.appointmentStatus ==
//                       AppointmentStatus.confirmed.name &&
//                   _appointDateFormatted(
//                     appointment.appointmentDate,
//                   ).isBefore(now)),
//         )
//         .toList();
//   }
//
//   List<ClientAppointmentsEntity> get cancelledAppointments {
//     return clientAppointments
//         .where(
//           (appointment) =>
//               appointment.appointmentStatus == AppointmentStatus.cancelled.name,
//         )
//         .toList();
//   }
//
//   DateTime _appointDateFormatted(String appointDate) =>
//       DateTimeFormatter.convertDateToString(appointDate);
//
//   @override
//   List<Object?> get props => [requestState, failureMessage, clientAppointments];
// }
