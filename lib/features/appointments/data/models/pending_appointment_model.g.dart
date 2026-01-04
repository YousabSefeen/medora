// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'pending_appointment_model.dart';
//
// PendingAppointmentModel _$PendingAppointmentModelFromJson(
//     Map<String, dynamic> json,
//     ) =>
//     PendingAppointmentModel(
//       appointmentDate: json['appointmentDate'] as String,
//       appointmentTime: json['appointmentTime'] as String,
//       doctorId: json['doctorId'] as String,
//       clientId: json['clientId'] as String,
//       appointmentStatus: json['appointmentStatus'] as String,
//       createdAt: PendingAppointmentModel._fromTimestamp(
//           json['createdAt'] as Timestamp),
//       expiresAt: PendingAppointmentModel._fromTimestamp(
//           json['expiresAt'] as Timestamp),
//     );
//
// Map<String, dynamic> _$PendingAppointmentModelToJson(
//     PendingAppointmentModel instance,
//     ) =>
//     <String, dynamic>{
//       'appointmentDate': instance.appointmentDate,
//       'appointmentTime': instance.appointmentTime,
//       'doctorId': instance.doctorId,
//       'clientId': instance.clientId,
//       'appointmentStatus': instance.appointmentStatus,
//       'createdAt':
//       PendingAppointmentModel._toTimestamp(instance.createdAt),
//       'expiresAt':
//       PendingAppointmentModel._toTimestamp(instance.expiresAt),
//     };
