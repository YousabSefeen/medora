import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AppointmentDateTime {
  final String date;
  final String time;
  final Timestamp timestamp;
  final DateTime dateTime;

  AppointmentDateTime({
    required this.date,
    required this.time,
  }) : dateTime = _parseDateTime(date, time),
        timestamp = Timestamp.fromDate(_parseDateTime(date, time));

  static DateTime _parseDateTime(String date, String time) {
    // تنظيف الوقت (إزالة مسافات زائدة)
    final cleanedTime = time.trim().toUpperCase();

    // تحديد التنسيق المناسب
    String timeFormat;
    if (cleanedTime.contains('AM') || cleanedTime.contains('PM')) {
      timeFormat = 'hh:mm a';
    } else {
      // افتراض أنه وقت 24 ساعة
      timeFormat = 'HH:mm';
    }

    final fullFormat = 'dd/MM/yyyy $timeFormat';
    final dateTimeString = '$date ${cleanedTime.replaceAll(' ', '')}';

    return DateFormat(fullFormat).parse(dateTimeString);
  }

  // Getters للعرض
  String get formattedDate => DateFormat('dd/MM/yyyy').format(dateTime);
  String get formattedTime => DateFormat('hh:mm a').format(dateTime);
  String get formattedDateTime => DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);

  // للغة العربية
  String get arabicDate => DateFormat('yyyy/MM/dd', 'ar').format(dateTime);
  String get arabicTime => DateFormat('hh:mm a', 'ar').format(dateTime);

  // للاستعلامات
  int get year => dateTime.year;
  int get month => dateTime.month;
  int get day => dateTime.day;
  int get hour => dateTime.hour;
  int get minute => dateTime.minute;

  // للتحقق
  bool get isPast => dateTime.isBefore(DateTime.now());
  bool get isToday {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }
}

// الاستخدام:
final appointment = AppointmentDateTime(
  date: '17/01/2026',
  time: '11:00 AM',
);


// حفظ في Firestore
