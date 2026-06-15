import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';

import '../repositories/auth_repository.dart';

class GetUserIdUseCase extends BaseUseCase<String, NoParams> {
  final AuthRepository authRepository;

  GetUserIdUseCase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.getUserId();
  }
}
