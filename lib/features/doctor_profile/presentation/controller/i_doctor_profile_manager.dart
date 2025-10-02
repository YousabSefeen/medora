





import 'package:medora/features/doctor_profile/presentation/controller/form_controllers/doctor_fields_controllers.dart' show DoctorFieldsControllers;

abstract class IDoctorProfileManager {
  // Medical specialties methods
  void toggleMedicalSpecialties(String specialty);
  bool get canSelectMoreSpecialties;
  void confirmMedicalSpecialtiesSelection();
  void syncTempSpecialtiesFromConfirmed();
  void searchSpecialty(String searchTerm);
  String get getLastSearchTerm;
  List<String> get getFilteredSpecialties;

  // Working days methods
  void toggleWorkingDay(String day);
  void confirmWorkingDaysSelection();
  void syncTempDaysFromConfirmed();

  // Working Hours methods
  void toggleWorkHoursExpanded();
  void updateWorkHoursSelected(bool isTimeRangeEmpty, String? from, String? to);

  // Profile submission
  void validateInputsAndSubmitProfile(DoctorFieldsControllers controllers);

  void resetStates();
}