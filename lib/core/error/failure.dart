import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show StripeException;
import 'package:medora/core/error/stripe_failure.dart' show StripeFailure;

import 'auth_exception.dart' show AuthException;


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
