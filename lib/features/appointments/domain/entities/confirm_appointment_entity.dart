import 'package:equatable/equatable.dart';

class ConfirmAppointmentEntity extends Equatable {
  // Patient info
  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  // Appointment info
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus; // confirmed

  const ConfirmAppointmentEntity({
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
  });

  @override
  List<Object?> get props => [
    patientName,
    patientGender,
    patientAge,
    patientProblem,
    appointmentDate,
    appointmentTime,
    appointmentStatus,
  ];
}
