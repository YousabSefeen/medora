import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/auth/data/data_sources/auth_remote_data_source.dart'
    show AuthRemoteDataSource;
import 'package:medora/features/auth/data/models/user_model.dart'
    show UserModel;
import 'package:medora/features/auth/domain/params/sign_in_params.dart'
    show SignInParams;
import 'package:medora/features/auth/domain/params/sign_up_params.dart'
    show SignUpParams;
import 'package:medora/features/auth/domain/repositories/auth_repository.dart'
    show AuthRepository;

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
    : _authRemoteDataSource = authRemoteDataSource;
  @override
  Future<Either<Failure, void>> signUp({
    required SignUpParams params,
  }) async {
    try {
      final userModel = UserModel(
        name: params.name,
        phone: params.phone,
        email: params.email,
        role: params.role,
        createdAt: '',
      );

      await _authRemoteDataSource.signUp(
        userModel: userModel,
        password: params.password,
      );
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }
  @override
  Future<Either<Failure, void>> signIn({required SignInParams params}) async {
    try {
      await _authRemoteDataSource.signIn(
        email: params.email,
        password: params.password,
      );
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }



  @override
  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = await _authRemoteDataSource.getUserId();
      return Right(userId);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return const Right(null);
    } catch (catchError) {
      return Left(ServerFailure(catchError: catchError));
    }
  }
}
