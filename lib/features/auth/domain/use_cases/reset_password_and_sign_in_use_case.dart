import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/auth/domain/params/reset_password_and_sign_in_params.dart';
import 'package:medora/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordAndSignInUseCase
    extends BaseUseCase<void, ResetPasswordParams> {
  final AuthRepository _authRepository;

  ResetPasswordAndSignInUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams email) async {
    final resetResult = await _authRepository.confirmPasswordReset(
      params: email,
    );

    return await resetResult.fold(
      (failure) {
        AppLogger.error('Reset failed: ${failure.errorMessage}');
        return Left(failure);
      },
      (_) async {
        AppLogger.info('Reset successful, signing in...');
        return await _authRepository.signIn(params: email.toSignInParams());
      },
    );
  }
}
