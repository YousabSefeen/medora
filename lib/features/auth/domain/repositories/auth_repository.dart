import 'package:dartz/dartz.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart'
    show SignInParams;
import 'package:medora/features/auth/domain/params/sign_up_params.dart'
    show SignUpParams;

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signUp({required SignUpParams params});

  Future<Either<Failure, void>> signIn({required SignInParams params});

  Future<Either<Failure, String>> getUserId();

  Future<Either<Failure, void>> signOut();


  // Future<Either<Failure, void>> forgotPassword({required String email});
  // Future<Either<Failure, void>> verifyEmail({required String email});
  // Future<Either<Failure, void>> verifyOTP({required String otp});
  // Future<Either<Failure, void>> resetPassword({required String password});
  // Future<Either<Failure, void>> changePassword({required String password});
  // Future<Either<Failure, void>> deleteAccount();
}
