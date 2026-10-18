import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';

import '../repositories/auth_repository.dart';

class FetchEmailFromCodeUseCase extends BaseUseCase<String, String> {
  final AuthRepository authRepository;

  FetchEmailFromCodeUseCase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await authRepository.fetchEmailFromCode(oobCode: params);
  }
}
