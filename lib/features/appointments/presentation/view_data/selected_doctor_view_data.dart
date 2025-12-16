


import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

class SelectedDoctorViewData {
  final String doctorId;
  final DoctorEntity doctorModel;

  SelectedDoctorViewData({required this.doctorId, required this.doctorModel});
}
