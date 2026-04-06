import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class AppointmentBookingUIModel {
  final DoctorEntity doctorEntity;
  final String appointmentDate;
  final String appointmentTime;

  AppointmentBookingUIModel({
    required this.doctorEntity,
    required this.appointmentDate,
    required this.appointmentTime,
  });
}
