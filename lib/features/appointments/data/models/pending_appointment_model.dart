//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:medora/features/appointments/domain/entities/pending_appointment_entity.dart';
//
// part 'pending_appointment_model.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// class PendingAppointmentModel {
//   final String appointmentDate;
//   final String appointmentTime;
//
//   final String doctorId;
//   final String clientId;
//
//   final String appointmentStatus;
//
//   @JsonKey(
//     fromJson: _fromTimestamp,
//     toJson: _toTimestamp,
//   )
//   final DateTime createdAt;
//
//   @JsonKey(
//     fromJson: _fromTimestamp,
//     toJson: _toTimestamp,
//   )
//   final DateTime expiresAt;
//
//   PendingAppointmentModel({
//     required this.appointmentDate,
//     required this.appointmentTime,
//     required this.doctorId,
//     required this.clientId,
//     required this.appointmentStatus,
//     required this.createdAt,
//     required this.expiresAt,
//   });
//
//   // ---------- JSON ----------
//
//   factory PendingAppointmentModel.fromJson(Map<String, dynamic> json) =>
//       _$PendingAppointmentModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PendingAppointmentModelToJson(this);
//
//   // ---------- Entity Mapping ----------
//
//   PendingAppointmentEntity toEntity() => PendingAppointmentEntity(
//     appointmentDate: appointmentDate,
//     appointmentTime: appointmentTime,
//     doctorId: doctorId,
//     clientId: clientId,
//     appointmentStatus: appointmentStatus,
//     createdAt: createdAt,
//     expiresAt: expiresAt,
//   );
//
//   factory PendingAppointmentModel.fromEntity(
//       PendingAppointmentEntity entity,
//       ) {
//     return PendingAppointmentModel(
//       appointmentDate: entity.appointmentDate,
//       appointmentTime: entity.appointmentTime,
//       doctorId: entity.doctorId,
//       clientId: entity.clientId,
//       appointmentStatus: entity.appointmentStatus,
//       createdAt: entity.createdAt,
//       expiresAt: entity.expiresAt,
//     );
//   }
//
//   // ---------- Timestamp Helpers ----------
//
//   static DateTime _fromTimestamp(Timestamp timestamp) =>
//       timestamp.toDate();
//
//   static Timestamp _toTimestamp(DateTime dateTime) =>
//       Timestamp.fromDate(dateTime);
// }
