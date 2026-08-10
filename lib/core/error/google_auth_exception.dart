import 'package:google_sign_in/google_sign_in.dart';
import 'package:medora/core/constants/app_strings/app_errors_strings.dart';

class GoogleAuthException {
  static String getMsgFromErrorCode({
    required GoogleSignInException exception,
  }) {
    switch (exception.code) {
      case GoogleSignInExceptionCode.unknownError:
        return AppErrorsStrings.unexpectedError;
      case GoogleSignInExceptionCode.canceled:
        return AppErrorsStrings.googleCanceled;
      case GoogleSignInExceptionCode.interrupted:
        return AppErrorsStrings.googleInterrupted;
      case GoogleSignInExceptionCode.clientConfigurationError:
        return AppErrorsStrings.googleClientConfigurationError;
      case GoogleSignInExceptionCode.providerConfigurationError:
        return AppErrorsStrings.googleProviderConfigurationError;
      case GoogleSignInExceptionCode.uiUnavailable:
        return AppErrorsStrings.googleUiUnavailable;
      case GoogleSignInExceptionCode.userMismatch:
        return AppErrorsStrings.googleUserMismatch;
    }
  }
}
