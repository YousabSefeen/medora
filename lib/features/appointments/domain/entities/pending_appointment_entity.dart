import 'package:equatable/equatable.dart' show Equatable;

class PendingAppointmentEntity extends Equatable {
  final String doctorId;
  final String clientId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;

  const PendingAppointmentEntity({
    required this.doctorId,
    required this.clientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
  });

  @override
  List<Object?> get props => [
    doctorId,
    clientId,
    appointmentDate,
    appointmentTime,
    appointmentStatus,
  ];
}
