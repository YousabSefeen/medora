import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart' show BookAppointmentEntity;

part 'confirm_appointment_model.g.dart';

@JsonSerializable()
class ConfirmAppointmentModel {
  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  final String appointmentStatus;
  final String appointmentDate;
  final String appointmentTime;

  ConfirmAppointmentModel({
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentStatus,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  factory ConfirmAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAppointmentModelToJson(this);


  ConfirmAppointmentModel toEntity() {
    return ConfirmAppointmentModel(
      patientName: patientName,
      patientGender: patientGender,
      patientAge: patientAge,
      patientProblem: patientProblem,
      appointmentStatus: appointmentStatus,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
    );
  }

  factory ConfirmAppointmentModel.fromEntity(ConfirmAppointmentModel entity) {
    return ConfirmAppointmentModel(
      patientName: entity.patientName,
      patientGender: entity.patientGender,
      patientAge: entity.patientAge,
      patientProblem: entity.patientProblem,
      appointmentStatus: entity.appointmentStatus,
      appointmentDate: entity.appointmentDate,
      appointmentTime: entity.appointmentTime,
    );
  }
}
