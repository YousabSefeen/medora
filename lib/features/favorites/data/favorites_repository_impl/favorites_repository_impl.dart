import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart';
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source.dart'
    show FavoritesRemoteDataSourceBase;
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;

class FavoritesRepositoryImpl extends FavoritesRepositoryBase {
  final FavoritesRemoteDataSourceBase favoritesRemoteDataSourceBase;

  FavoritesRepositoryImpl({required this.favoritesRemoteDataSourceBase});

  @override
  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId) async {
    try {
      await favoritesRemoteDataSourceBase.addDoctorToFavorites(doctorId);
      return right(null);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getFavoritesDoctors() async {
    try {
      final favorites = await favoritesRemoteDataSourceBase.getFavoritesDoctors();
      return right(favorites);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, bool>> isDoctorFavorite(String doctorId) async {
    try {
      final isDoctorFavorite = await favoritesRemoteDataSourceBase
          .isDoctorFavorite(doctorId);
      return right(isDoctorFavorite);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, void>> removeDoctorFromFavorites(
    String doctorId,
  ) async {
    try {
      await favoritesRemoteDataSourceBase.removeDoctorFromFavorites(doctorId);
      return right(null);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }
}
