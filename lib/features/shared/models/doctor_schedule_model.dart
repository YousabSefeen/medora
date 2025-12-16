
import 'package:medora/features/shared/domain/entities/doctor_availability_entity.dart' show DoctorAvailabilityEntity;

class DoctorScheduleModel {
  final String doctorId;
  final DoctorAvailabilityEntity doctorAvailability;

  DoctorScheduleModel({
    required this.doctorId,
    required this.doctorAvailability,
  });
}
