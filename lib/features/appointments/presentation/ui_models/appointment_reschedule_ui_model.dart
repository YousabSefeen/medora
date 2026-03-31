class AppointmentRescheduleUIModel {
  final String oldAppointmentDate;
  final String oldAppointmentTime;
  final String newAppointmentDate;
  final String newAppointmentTime;

  const AppointmentRescheduleUIModel({
    required this.oldAppointmentDate,
    required this.oldAppointmentTime,
    required this.newAppointmentDate,
    required this.newAppointmentTime,
  });
}
