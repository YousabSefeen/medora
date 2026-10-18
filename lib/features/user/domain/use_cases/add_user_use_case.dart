import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';

import '../repositories/user_repository.dart';
import '../value_objects/add_user_params.dart';

class AddUserUseCase extends BaseUseCase<Unit, AddUserParams> {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(AddUserParams params) async {
    return await userRepository.addUser(params: params);
  }
}
