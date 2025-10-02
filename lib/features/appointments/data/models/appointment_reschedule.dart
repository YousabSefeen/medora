class AppointmentRescheduleData {
  final String oldAppointmentDate;
  final String oldAppointmentTime;
  final String newAppointmentDate;
  final String newAppointmentTime;

  const AppointmentRescheduleData({
    required this.oldAppointmentDate,
    required this.oldAppointmentTime,
    required this.newAppointmentDate,
    required this.newAppointmentTime,
  });
}
