enum EmptyStateSource {
  /// Empty state originates from appointment-related filters
  /// (upcoming, completed, canceled appointments)
  appointment,

  /// Empty state originates from booking-related scenarios
  /// (fully booked, not working day, past date)
  booking,
}