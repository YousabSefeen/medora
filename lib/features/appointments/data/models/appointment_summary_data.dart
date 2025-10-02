
import 'package:medora/features/appointments/data/models/picked_doctor_info_model.dart' show PickedDoctorInfoModel;

class AppointmentSummaryData {
  final PickedDoctorInfoModel pickedDoctorInfo;
  final String date;
  final String time;

  AppointmentSummaryData({
    required this.pickedDoctorInfo,
    required this.date,
    required this.time,
  });
}
