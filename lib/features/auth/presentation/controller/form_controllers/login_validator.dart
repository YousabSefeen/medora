// class LoginValidator {
//   static const String _warningEmoji = '⚠️';
//
//   static String _formatError(String message) {
//     return '$_warningEmoji  $message';
//   }
//
//   static String? validateEmail(String? value) {
//     final cleanedValue = value?.trim() ?? '';
//
//     if (cleanedValue.isEmpty) {
//       return _formatError('Please enter your email address');
//     }
//
//     if (!cleanedValue.contains('@')) {
//       return _formatError('Please enter a valid email address');
//     }
//
//     return null;
//   }
//
//   static String? validatePassword(String? value) {
//     final cleanedValue = value?.trim() ?? '';
//
//     if (cleanedValue.isEmpty) {
//       return _formatError('Please enter your password');
//     }
//
//     if (cleanedValue.length < 6) {
//       return _formatError('Password must be at least 6 characters');
//     }
//
//     return null;
//   }
// }
