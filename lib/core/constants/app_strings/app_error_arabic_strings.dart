abstract class AppErrorArabicStrings {
  // Gemini & AI Errors
  static const String geminiOverloaded = 'خوادم التحليل الطبي مزدحمة حالياً. يرجى المحاولة مرة أخرى بعد ثوانٍ.';
  static const String geminiServiceUnavailable = 'الخدمة غير متوفرة حالياً (503). نرجو الانتظار قليلاً.';
  static const String geminiQuotaExceeded = 'لقد تجاوزت الحد المسموح من الطلبات اليوم.';
  static const String rateLimitExceeded = 'لقد قمت بإرسال الكثير من الطلبات في وقت قصير. يرجى الانتظار قليلاً.';

  // Access & Permission Errors
  static const String serviceRestricted = 'الخدمة غير متاحة حالياً، يرجى المحاولة لاحقاً أو التأكد من منطقتك الجغرافية.';
  static const String invalidRequest = 'بيانات الطلب غير صالحة، يرجى محاولة التقاط صورة أوضح.';

  // Network Errors
  static const String networkError = 'يرجى التحقق من اتصالك بالإنترنت والمحاولة مجدداً.';
  static const String timeoutError = 'استغرق الطلب وقتاً طويلاً، حاول مرة أخرى.';

  // Fallback
  static const String unknownError = 'حدث خطأ غير متوقع، نحن نعمل على إصلاحه.';
}