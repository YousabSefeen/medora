import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart'
    show SignUpParams;

import '../repositories/auth_repository.dart';

class SignUpUseCase extends BaseUseCase<void, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await authRepository.signUp(params: params);
  }
}
