import 'package:equatable/equatable.dart' show Equatable;

class DeleteAppointmentParams extends Equatable {
  final String doctorId;
  final String appointmentId;

  const DeleteAppointmentParams({
    required this.doctorId,
    required this.appointmentId,
  });

  Map<String, dynamic> toMap() => {
    'doctorId': doctorId,
    'appointmentId': appointmentId,
  };

  @override
  List<Object?> get props => [appointmentId, doctorId];
}
