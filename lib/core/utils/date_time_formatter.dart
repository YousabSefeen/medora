import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatFull(DateTime date) =>
      DateFormat('yyyy-MM-dd hh:mm a').format(date);

  static String dateAndTimeNowS() => formatFull(DateTime.now());

  static String timeString(DateTime time) =>
      DateFormat('hh:mm a').format(time).toString();

  // static String formatTimeOnly(DateTime date) => DateFormat('hh:mm a').format(date);
  //
  // static String formatDateOnly(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
  String extractDate(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm a').parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime); // الناتج: 2025-05-04
  }

  String extractTime(String dateTimeString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm a').parse(dateTimeString);
    return DateFormat('hh:mm a').format(dateTime); // الناتج: 2025-05-04
  }

  //*****************************************************************************************
  static DateTime parseTime(String time, DateTime date) {
    final format = DateFormat.jm(); // from intl package
    final parsed = format.parse(time);
    return DateTime(
        date.year, date.month, date.day, parsed.hour, parsed.minute);
  }

  static DateTime newParseTime(String time, DateTime date) {
    final timeSplit = time.split(':');
    final hour = int.parse(timeSplit[0]);
    final minuteWithPeriod = timeSplit[1];
    final minute = int.parse(minuteWithPeriod.split(' ')[0]);

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  static String convertSelectedDateToString(DateTime selectedDateTime) {
    DateTime date = DateTime.parse(selectedDateTime.toString());
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);

    return formattedDate;
  }
  static DateTime convertDateToString(String date) {

    final formattedDate = DateFormat('dd/MM/yyyy').parse(date);

    return formattedDate;
  }
  static String convertDateToNameDay({required DateTime date}) =>
      DateFormat.EEEE('en_US').format(date);

  static String convertTimeToString({required DateTime time}) {
    // تحويل الوقت الي (DateTime Type)

    final DateTime time = DateFormat('hh:mm a').parse('12:00 AM');
    //  ومن ثم يجب تحويله مرة اخرة الي (String Type ) للحصول علي الوقت كسلسلة نصية

    final timeString = DateFormat.jm().format(DateTime.parse(time.toString()));
    return timeString;
  }
}
