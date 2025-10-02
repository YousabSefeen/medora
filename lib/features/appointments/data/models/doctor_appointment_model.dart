
import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/appointments/data/models/appointment_model.dart' show AppointmentModel;

part 'doctor_appointment_model.g.dart';

@JsonSerializable()
class DoctorAppointmentModel {
  final String appointmentId;

  final AppointmentModel appointmentModel;

  DoctorAppointmentModel(
      {required this.appointmentId, required this.appointmentModel});

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAppointmentModelToJson(this);
}
