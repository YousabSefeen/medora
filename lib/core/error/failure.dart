import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart' show StripeException;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medora/core/error/google_auth_exception.dart';
import 'package:medora/core/error/stripe_exception.dart' show StripeFailure;

import 'auth_exception.dart' show AuthException;

abstract class Failure {
  final Object catchError;

  Failure({required this.catchError});

  String get errorMessage;
}

class ServerFailure extends Failure {
  ServerFailure({required super.catchError});

  @override
  String get errorMessage {
    if (catchError is FirebaseAuthException) {
      final errorCode = (catchError as FirebaseAuthException).code;
      return AuthException.getMsgFromErrorCode(errorCode: errorCode);
    } else if (catchError is GoogleSignInException) {
      return GoogleAuthException.getMsgFromErrorCode(
        exception: catchError as GoogleSignInException,
      );
    } else if (catchError is HttpException) {
      return 'Http HttpException';
    } else if (catchError is StripeException) {
      return StripeFailure(catchError: catchError).errorMessage;
    } else {
      return 'An unknown error occurred. Please try again later.${catchError.toString()}';
    }
  }

  @override
  String toString() => errorMessage;
}

class LocalFailure extends Failure {
  LocalFailure({required super.catchError});

  @override
  String get errorMessage {
    if (catchError is FormatException) {
      return 'Data formatting error occurred while reading local data.';
    } else if (catchError is FileSystemException) {
      return 'Unable to access device storage. Please check your permissions.';
    } else {
      return 'An unexpected error occurred while accessing local storage: ${catchError.toString()}';
    }
  }

  @override
  String toString() => errorMessage;
}
