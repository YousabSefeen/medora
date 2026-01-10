import 'package:equatable/equatable.dart' show Equatable;

class CancelAppointmentsParams extends Equatable {
  final String doctorId;
  final String appointmentId;

  const CancelAppointmentsParams({
    required this.doctorId,
    required this.appointmentId,
  });

  Map<String, dynamic> toMap() => {
    'doctorId': doctorId,
    'appointmentId': appointmentId,
  };

  @override
  List<Object?> get props => [doctorId, appointmentId];
}
