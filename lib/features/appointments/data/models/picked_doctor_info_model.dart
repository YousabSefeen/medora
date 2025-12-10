import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

class PickedDoctorInfoModel {
  final String doctorId;
  final DoctorModel doctorModel;

  PickedDoctorInfoModel({required this.doctorId, required this.doctorModel});
}
