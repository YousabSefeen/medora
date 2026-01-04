


import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

class AppointmentBookingData {

  final DoctorEntity doctorEntity;
  final String appointmentDate;
  final String appointmentTime;

  AppointmentBookingData({  required this.doctorEntity, required this.appointmentDate, required this.appointmentTime});
}
