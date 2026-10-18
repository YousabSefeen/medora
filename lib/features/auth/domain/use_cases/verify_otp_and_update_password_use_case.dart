import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/auth/domain/params/verify_otp_and_update_password_params.dart';

import '../repositories/auth_repository.dart';

class VerifyOtpAndUpdatePasswordUseCase
    extends BaseUseCase<void, VerifyOtpAndUpdatePasswordParams> {
  final AuthRepository authRepository;

  VerifyOtpAndUpdatePasswordUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(
    VerifyOtpAndUpdatePasswordParams params,
  ) async {
    return await authRepository.verifyOtpAndUpdatePassword(
      email: params.email,
      verificationId: params.verificationId,
      smsCode: params.smsCode,
      newPassword: params.newPassword,
    );
  }
}
