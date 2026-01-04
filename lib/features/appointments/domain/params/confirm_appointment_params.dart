import 'package:equatable/equatable.dart' show Equatable;

class ConfirmAppointmentParams extends Equatable {
  final String doctorId;
  final String appointmentId;
  final String appointmentDate;
  final String appointmentTime;
  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  const ConfirmAppointmentParams({
    required this.doctorId,
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
  });

  Map<String, dynamic> toMap() => {
    'doctorId': doctorId,
    'appointmentId': appointmentId,
    'appointmentDate': appointmentDate,
    'appointmentTime': appointmentTime,
    'patientName': patientName,
    'patientGender': patientGender,
    'patientAge': patientAge,
    'patientProblem': patientProblem,
  };

  @override
  List<Object?> get props => [
    doctorId,
    appointmentId,
    appointmentDate,
    appointmentTime,
    patientName,
    patientGender,
    patientAge,
    patientProblem,
  ];
}
