import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source.dart'
    show FavoritesRemoteDataSource;
import 'package:medora/features/favorites/domain/repositories/favorites_repository.dart'
    show FavoritesRepository;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart';
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final FavoritesRemoteDataSource favoritesRemoteDataSource;

  FavoritesRepositoryImpl({required this.favoritesRemoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getFavoriteIds() async {
    try {
      final favoriteIds = await favoritesRemoteDataSource.getFavoriteIds();
      return right(favoriteIds);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId) async {
    try {
      await favoritesRemoteDataSource.addDoctorToFavorites(doctorId);
      return right(null);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, void>> removeDoctorFromFavorites(
    String doctorId,
  ) async {
    try {
      await favoritesRemoteDataSource.removeDoctorFromFavorites(doctorId);
      return right(null);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>>
  getFavoritesDoctors({required PaginationParameters parameters}) async {
    try {
      final doctorList =
          await favoritesRemoteDataSource.getFavoritesDoctors(parameters)
              as PaginatedDataResponse<DoctorEntity>;
      return right(doctorList);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
