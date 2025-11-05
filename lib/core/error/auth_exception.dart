



class AuthException {
  static String getMsgFromErrorCode({required String errorCode}) {
    switch (errorCode) {
    // Login Errors
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please check your email and password.';

      case 'user-not-found':
        return 'No account found for this email address.';

      case 'wrong-password':
        return 'The password you entered is incorrect.';

      case 'user-disabled':
        return 'This user account has been disabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

    // Sign up Errors
      case 'email-already-in-use':
        return 'This email address is already in use. If it’s your account, try logging in.';

      case 'invalid-email':
        return 'The email address format is invalid.';

      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';

      case 'weak-password':
        return 'The password is too weak. Please use at least 6 characters.';

    // General or Connectivity Errors
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';

      case 'internal-error':
        return 'An internal error occurred. Please try again later.';

      case 'missing-email':
        return 'Email address is required.';

      case 'missing-password':
        return 'Password is required.';

      case 'invalid-api-key':
        return 'Invalid API key. Please check your Firebase configuration.';

      default:
        return 'An unexpected error occurred: $errorCode';
    }
  }
}