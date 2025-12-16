import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
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

  ClientAppointmentsEntity toEntity() {
    return ClientAppointmentsEntity(
      clientId: clientId,
      doctorId: doctorId,
      appointmentId: appointmentId,
      patientName: patientName,
      patientGender: patientGender,
      patientAge: patientAge,
      patientProblem: patientProblem,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      appointmentStatus: appointmentStatus,
      doctorEntity: doctorModel.toEntity(),
    );
  }

  factory ClientAppointmentsModel.fromEntity(ClientAppointmentsEntity entity) {
    return ClientAppointmentsModel(
      clientId: entity.clientId,
      doctorId: entity.doctorId,
      appointmentId: entity.appointmentId,
      patientName: entity.patientName,
      patientGender: entity.patientGender,
      patientAge: entity.patientAge,
      patientProblem: entity.patientProblem,
      appointmentDate: entity.appointmentDate,
      appointmentTime: entity.appointmentTime,
      appointmentStatus: entity.appointmentStatus,

      doctorModel: DoctorModel.fromEntity(entity.doctorEntity),
    );
  }
}
