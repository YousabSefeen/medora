// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAppointmentModel _$BookAppointmentModelFromJson(
        Map<String, dynamic> json) =>
    BookAppointmentModel(
      patientName: json['patientName'] as String,
      patientGender: json['patientGender'] as String,
      patientAge: json['patientAge'] as String,
      patientProblem: json['patientProblem'] as String,
          appointmentStatus: json['appointmentStatus'] as String,
      appointmentDate: json['appointmentDate'] as String,
      appointmentTime: json['appointmentTime'] as String,
    );

Map<String, dynamic> _$BookAppointmentModelToJson(
        BookAppointmentModel instance) =>
    <String, dynamic>{
      'patientName': instance.patientName,
      'patientGender': instance.patientGender,
      'patientAge': instance.patientAge,
      'patientProblem': instance.patientProblem,
      'appointmentStatus': instance.appointmentStatus,
      'appointmentDate': instance.appointmentDate,
      'appointmentTime': instance.appointmentTime,
    };
