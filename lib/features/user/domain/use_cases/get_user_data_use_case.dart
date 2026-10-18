import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/user/domain/entities/user_entity.dart';

import '../repositories/user_repository.dart';

class GetUserDataUseCase extends BaseUseCase<UserEntity, NoParams> {
  final UserRepository userRepository;

  GetUserDataUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await userRepository.getUserData();
  }
}
