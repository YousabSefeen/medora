import 'package:equatable/equatable.dart' show Equatable;

class AppointmentEntity extends Equatable {
  final String clientId;
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentStatus;

  const AppointmentEntity({
    required this.clientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentStatus,
  });

  @override
  List<Object?> get props => [
    clientId,
    appointmentDate,
    appointmentTime,
    appointmentStatus,
  ];
}
