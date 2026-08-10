import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:medora/features/auth/domain/params/reset_password_and_sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart';
import 'package:medora/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
    : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, void>> signUp({required SignUpParams params}) async {
    try {
      await _authRemoteDataSource.signUp(params: params);
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, void>> signIn({required SignInParams params}) async {
    try {
      await _authRemoteDataSource.signIn(params: params);
      return const Right(null);
    } catch (catchError) {
      AppLogger.warning('catchError $catchError');
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _authRemoteDataSource.sendPasswordResetEmail(email: email);
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, String>> fetchEmailFromCode({
    required String oobCode,
  }) async {
    try {
      final email = await _authRemoteDataSource.fetchEmailFromCode(
        oobCode: oobCode,
      );
      return Right(email);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPasswordReset({
    required ResetPasswordParams params,
  }) async {
    try {
      await _authRemoteDataSource.confirmPasswordReset(params: params);
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  //  Step 1 in Forget Password(By phone Number): Get the phone from the Firestore and send the OTP
  @override
  Future<Either<Failure, void>> verifyPhoneAndSendOtp({
    required String email,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onVerificationFailed,
  }) async {
    try {
      await _authRemoteDataSource.verifyPhoneAndSendOtp(
        email: email,
        onCodeSent: onCodeSent,
        onVerificationFailed: onVerificationFailed,
      );
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  //  Step 2 in Forget Password(By phone Number): Check the OTP code and update the encrypted password immediately
  @override
  Future<Either<Failure, void>> verifyOtpAndUpdatePassword({
    required String email,
    required String verificationId,
    required String smsCode,
    required String newPassword,
  }) async {
    try {
      await _authRemoteDataSource.verifyOtpAndUpdatePassword(
        email: email,
        verificationId: verificationId,
        smsCode: smsCode,
        newPassword: newPassword,
      );
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }
}
