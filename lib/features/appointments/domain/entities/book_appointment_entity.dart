import 'package:equatable/equatable.dart' show Equatable;

class BookAppointmentEntity extends Equatable {
  final String patientName;
  final String patientGender;
  final String patientAge;
  final String patientProblem;

  final String appointmentStatus;
  final String appointmentDate;
  final String appointmentTime;


  const BookAppointmentEntity({
    required this.patientName,
    required this.patientGender,
    required this.patientAge,
    required this.patientProblem,
    required this.appointmentStatus,
    required this.appointmentDate,
    required this.appointmentTime,

  });

  @override
  List<Object?> get props => [
    patientName,
   patientGender,
    patientAge,
    patientProblem,

    appointmentStatus,
    appointmentDate,
    appointmentTime,

  ];
}
