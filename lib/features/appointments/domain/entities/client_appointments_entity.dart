import 'package:equatable/equatable.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

class ClientAppointmentsEntity extends Equatable {
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
  final DoctorEntity doctorEntity;

  const ClientAppointmentsEntity({
    required this.clientId,
    required this.doctorId,
    required this.appointmentId,
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
    required this.doctorEntity,
  });

  @override
  List<Object?> get props => [
    appointmentId,
    clientId,
    doctorId,

    patientName,
    patientGender,
    patientAge,
    patientProblem,
    appointmentDate,
    appointmentTime,
    appointmentStatus,
    doctorEntity,
  ];
}
