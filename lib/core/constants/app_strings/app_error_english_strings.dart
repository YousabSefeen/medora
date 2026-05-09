abstract class AppErrorEnglishStrings {
  // Gemini & AI Errors
  static const String geminiOverloaded = 'Medical analysis servers are currently busy. Please try again in a few seconds.';
  static const String geminiServiceUnavailable = 'Service is temporarily unavailable (503). Please wait a moment.';
  static const String geminiQuotaExceeded = 'Daily request limit has been reached.';
  static const String rateLimitExceeded = 'You have sent too many requests in a short time. Please wait a moment.';

  // Access & Permission Errors
  static const String serviceRestricted = 'Service is restricted or unavailable in your region.';
  static const String invalidRequest = 'Invalid request data, please try taking a clearer photo.';

  // Network Errors
  static const String networkError = 'Please check your internet connection and try again.';
  static const String timeoutError = 'The request took too long to respond. Please try again.';

  // Fallback
  static const String unknownError = 'An unexpected error occurred, we are working on it.';
}