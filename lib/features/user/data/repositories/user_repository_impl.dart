import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/user/data/models/user_model.dart';
import 'package:medora/features/user/domain/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart';
import '../../domain/value_objects/add_user_params.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl({required UserRemoteDataSource userRemoteDataSource})
    : _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<Either<Failure, Unit>> addUser({required AddUserParams params}) async {
    try {
      await _userRemoteDataSource.addUser(params: params);
      return const Right(unit);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final UserModel userData = await _userRemoteDataSource.getUserData();
      return Right(userData);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }
}
