import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';

import '../repositories/auth_repository.dart';

class SignOutUseCase extends BaseUseCase<void, NoParams> {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
