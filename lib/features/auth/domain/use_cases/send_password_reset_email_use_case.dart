import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';

import '../repositories/auth_repository.dart';

class SendPasswordResetEmailUseCase extends BaseUseCase<void, String> {
  final AuthRepository authRepository;

  SendPasswordResetEmailUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(String email) async {
    return await authRepository.sendPasswordResetEmail(email: email);
  }
}
