/// Represents all possible appointment availability states
/// including both available and unavailable reasons
enum AppointmentAvailabilityStatus {
  available,

  /// The selected date is in the past (before current date)
  pastDate,

  /// The doctor doesn't work on the selected date
  doctorNotWorkingOnSelectedDate,
}
