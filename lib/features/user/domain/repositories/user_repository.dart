import 'package:dartz/dartz.dart';
import 'package:medora/features/user/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';
import '../value_objects/add_user_params.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> addUser({required AddUserParams params});

  Future<Either<Failure, UserEntity>> getUserData();
}
