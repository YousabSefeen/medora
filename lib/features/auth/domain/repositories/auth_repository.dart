import 'package:dartz/dartz.dart';
import 'package:medora/features/auth/domain/params/reset_password_and_sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signUp({required SignUpParams params});

  Future<Either<Failure, void>> signIn({required SignInParams params});

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> sendPasswordResetEmail({required String email});

  Future<Either<Failure, String>> fetchEmailFromCode({required String oobCode});

  Future<Either<Failure, void>> confirmPasswordReset({
    required ResetPasswordParams params,
  });

  Future<Either<Failure, void>> verifyPhoneAndSendOtp({
    required String email,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onVerificationFailed,
  });

  Future<Either<Failure, void>> verifyOtpAndUpdatePassword({
    required String email,
    required String verificationId,
    required String smsCode,
    required String newPassword,
  });
}
