






import 'package:medora/features/shared/models/availability_model.dart' show DoctorAvailabilityModel;

class DoctorScheduleModel{

  final String doctorId;
  final DoctorAvailabilityModel  doctorAvailability;

  DoctorScheduleModel({
    required this.doctorId,
    required this.doctorAvailability,
  });
}