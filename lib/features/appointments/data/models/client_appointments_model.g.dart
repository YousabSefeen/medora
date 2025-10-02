// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_appointments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientAppointmentsModel _$ClientAppointmentsModelFromJson(
        Map<String, dynamic> json) =>
    ClientAppointmentsModel(
      appointmentId: json['appointmentId'] as String,
      clientId: json['clientId'] as String,
      doctorId: json['doctorId'] as String,
      patientName: json['patientName'] as String,
      patientGender: json['patientGender'] as String,
      patientAge: json['patientAge'] as String,
      patientProblem: json['patientProblem'] as String,
      appointmentDate: json['appointmentDate'] as String,
      appointmentTime: json['appointmentTime'] as String,
      appointmentStatus: json['appointmentStatus'] as String,
      doctorModel:
          DoctorModel.fromJson(json['doctorModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientAppointmentsModelToJson(
        ClientAppointmentsModel instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'doctorId': instance.doctorId,
      'appointmentId': instance.appointmentId,
      'patientName': instance.patientName,
      'patientGender': instance.patientGender,
      'patientAge': instance.patientAge,
      'patientProblem': instance.patientProblem,
      'appointmentDate': instance.appointmentDate,
      'appointmentTime': instance.appointmentTime,
      'appointmentStatus': instance.appointmentStatus,
      'doctorModel': instance.doctorModel.toJson(),
    };
