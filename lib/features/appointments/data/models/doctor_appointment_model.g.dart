// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorAppointmentModel _$DoctorAppointmentModelFromJson(
  Map<String, dynamic> json,
) => DoctorAppointmentModel(
  appointmentId: json['appointmentId'] as String,
  appointmentModel: AppointmentModel.fromJson(
    json['appointmentModel'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DoctorAppointmentModelToJson(
  DoctorAppointmentModel instance,
) => <String, dynamic>{
  'appointmentId': instance.appointmentId,
  'appointmentModel': instance.appointmentModel,
};
