import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart'
    show SignInParams;

import '../repositories/auth_repository.dart';

class SignInUseCase extends BaseUseCase<void, SignInParams> {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(SignInParams email) async {
    return await authRepository.signIn(params: email);
  }
}
