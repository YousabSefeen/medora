// ============================================================
// 📦 features/auth/data/exceptions/auth_exception.dart
// ============================================================

import 'package:medora/core/constants/app_strings/app_errors_strings.dart';

class AuthException {
  static String getMsgFromErrorCode({required String errorCode}) {
    switch (errorCode) {
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return AppErrorsStrings.invalidCredentials;

      case 'user-not-found':
        return AppErrorsStrings.userNotFound;

      case 'wrong-password':
        return AppErrorsStrings.wrongPassword;

      case 'user-disabled':
        return AppErrorsStrings.userDisabled;

      case 'too-many-requests':
        return AppErrorsStrings.tooManyRequests;

      case 'email-already-in-use':
        return AppErrorsStrings.emailAlreadyInUse;

      case 'invalid-email':
        return AppErrorsStrings.invalidEmail;

      case 'operation-not-allowed':
        return AppErrorsStrings.operationNotAllowed;

      case 'weak-password':
        return AppErrorsStrings.weakPassword;

      case 'network-request-failed':
        return AppErrorsStrings.networkRequestFailed;

      case 'internal-error':
        return AppErrorsStrings.internalError;

      case 'missing-email':
        return AppErrorsStrings.missingEmail;

      case 'missing-password':
        return AppErrorsStrings.missingPassword;

      case 'invalid-api-key':
        return AppErrorsStrings.invalidApiKey;

      case 'account-exists-with-different-credential':
        return AppErrorsStrings.accountExistsWithDifferentCredential;

      case 'expired-action-code':
        return AppErrorsStrings.expiredActionCode;

      case 'invalid-action-code':
        return AppErrorsStrings.invalidActionCode;

      default:
        return '${AppErrorsStrings.unexpectedError} (Error code: $errorCode)';
    }
  }
}
