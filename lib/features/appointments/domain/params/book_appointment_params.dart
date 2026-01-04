import 'package:equatable/equatable.dart' show Equatable;

class BookAppointmentParams extends Equatable {
  final String doctorId;
  final String appointmentDate;
  final String appointmentTime;

  const BookAppointmentParams({
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  Map<String, dynamic> toMap() => {'doctorId': doctorId, 'appointmentDate': appointmentDate, 'appointmentTime': appointmentTime};

  @override
  List<Object?> get props => [doctorId, appointmentDate, appointmentTime];
}
