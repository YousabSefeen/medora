import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show StripeException;
import 'package:medora/core/error/stripe_failure.dart' show StripeFailure;


abstract class Failure {
  final Object catchError;

  Failure({required this.catchError});
}

class ServerFailure extends Failure {
  ServerFailure({required super.catchError});

  String get errorMessage {
    if (catchError is FirebaseAuthException) {
      final errorCode = (catchError as FirebaseAuthException).code;
      return AuthException.getMsgFromErrorCode(errorCode: errorCode);
    } else if (catchError is HttpException) {
      return 'Http HttpException';
    } else if(catchError is StripeException){
      return StripeFailure(catchError: catchError).errorMessage;
    }else {
      return 'An unknown error occurred. Please try again later.${catchError.toString()}';
    }
  }

  @override
  String toString() {
    return errorMessage;
  }
}

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

/// Old
/*class AuthException {
  static String getMsgFromErrorCode({required String errorCode}) {
    switch (errorCode) {
      case "INVALID_LOGIN_CREDENTIALS":
        return "Invalid login credentials, please make sure of the email address and the password";

      case "invalid-email":
        return "Your email address appears to be malformed.";

      case "wrong-password":
        return "Your password is wrong.";
      case "user-not-found":
        return "User with this email doesn't exist.";
      case "user-disabled":
        return "User with this email has been disabled.";
      case "too-many-requests":
        return "Too many requests. Try again later";
      case "operation-not-allowed":
        return "Message for operation not allowed";
      case "email-already-in-use":
        return "Already created an account in this Email, if is you, you can try Login.";
      default:
        return errorCode;
    }
  }
}*/
