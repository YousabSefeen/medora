import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

part 'client_appointments_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ClientAppointmentsModel {
  final String clientId;
  final String doctorId;
  final String appointmentId;
  final String patientName;

  final String patientGender;

  final String patientAge;
  final String patientProblem;

  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;

  final DoctorModel doctorModel;

  ClientAppointmentsModel({
    required this.appointmentId,
    required this.clientId,
    required this.doctorId,
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
    required this.doctorModel,
  });

  factory ClientAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      _$ClientAppointmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClientAppointmentsModelToJson(this);
}
