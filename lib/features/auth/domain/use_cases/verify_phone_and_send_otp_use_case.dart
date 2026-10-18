import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/auth/domain/params/verify_phone_and_send_otp_params.dart';

import '../repositories/auth_repository.dart';

class VerifyPhoneAndSendOtpUseCase
    extends BaseUseCase<void, VerifyPhoneAndSendOtpParams> {
  final AuthRepository authRepository;

  VerifyPhoneAndSendOtpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(VerifyPhoneAndSendOtpParams params) async {
    return await authRepository.verifyPhoneAndSendOtp(
      email: params.email,
      onCodeSent: params.onCodeSent,
      onVerificationFailed: params.onVerificationFailed,
    );
  }
}
