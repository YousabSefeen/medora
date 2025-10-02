import 'package:intl/intl.dart';

import 'date_time_formatter.dart';

class TimeSlotHelper {


 static bool isSelectedDateBeforeToday(DateTime selectedDate) {
    final now = DateTime.now();
    return selectedDate.isBefore(DateTime(now.year, now.month, now.day));
  }
  static bool doesDoctorWorkOnDate({
    required DateTime selectedDate,
    required List<String> doctorWorkingDays,
  }) {
    final selectedDayName =
        DateTimeFormatter.convertDateToNameDay(date: selectedDate);

    return doctorWorkingDays.contains(selectedDayName);
  }

  static List<String> generateHourlyTimeSlots({
    required String startTime,
    required String endTime,
  }) {
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    DateTime currentTime = timeFormatter.parse(startTime);
    final DateTime endTimeParsed = timeFormatter.parse(endTime);

    List<String> hourlySlots = [];
    while (currentTime.isBefore(endTimeParsed)) {
      hourlySlots.add(timeFormatter.format(currentTime));
      currentTime = currentTime.add(const Duration(hours: 1));
    }

    return hourlySlots;
  }

  static List<String> filterAvailableTimeSlots({
    required List<String> totalTimeSlots,
    required List<String> reservedTimeSlots,
  }) =>
      totalTimeSlots
          .where((slot) => !reservedTimeSlots.contains(slot))
          .toList();
}
