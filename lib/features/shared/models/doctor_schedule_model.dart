import 'package:medora/features/shared/data/models/doctor_availability_model.dart'
    show DoctorAvailabilityModel;

class DoctorScheduleModel {
  final String doctorId;
  final DoctorAvailabilityModel doctorAvailability;

  DoctorScheduleModel({
    required this.doctorId,
    required this.doctorAvailability,
  });
}
