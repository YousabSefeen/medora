


import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

class SelectedDoctorData {
  final String doctorId;
  final DoctorEntity doctorModel;

  SelectedDoctorData({required this.doctorId, required this.doctorModel});
}
