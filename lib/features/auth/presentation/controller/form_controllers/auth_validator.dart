


class AuthValidator {
  static const String _warningEmoji = '⚠️';

  static String _formatError(String message) {
    return '$_warningEmoji  $message';
  }

  // مشتركة بين الشاشتين
  static String? validateEmail(String? value) {
    final cleanedValue = value?.trim() ?? '';
    if (cleanedValue.isEmpty) return _formatError('Please enter your email address');
    if (!cleanedValue.contains('@')) return _formatError('Please enter a valid email address');
    return null;
  }

  // مشتركة بين الشاشتين
  static String? validatePassword(String? value) {
    final cleanedValue = value?.trim() ?? '';
    if (cleanedValue.isEmpty) return _formatError('Please enter your password');
    if (cleanedValue.length < 6) return _formatError('Password must be at least 6 characters');

    return null;
  }

  // خاص بشاشة الـ Register فقط
  static String? validateUserName(String? value) {
    final cleanedValue = value?.trim() ?? '';
    if (cleanedValue.isEmpty) return _formatError('Please enter your name');
    return null;
  }

  // خاص بشاشة الـ Register فقط
  static String? validatePhoneNumber(String? value) {
    final cleanedValue = value?.trim() ?? '';
    if (cleanedValue.isEmpty) return _formatError('Please enter your phone number.');
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value!)) return _formatError('A valid phone number is required.');
    // يمكنك إضافة فحص لطول الرقم هنا
    return null;
  }

  // خاص بشاشة الـ Register فقط (تأكيد كلمة المرور)
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) return _formatError('Please confirm your password');
    if (value != originalPassword) return _formatError('Passwords do not match');
    return null;
  }
}