import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

abstract class FavoritesRepository {
  Future<Either<Failure, List<String>>> getFavoriteIds();

  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>>
  getFavoritesDoctors({required PaginationParameters parameters});

  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId);

  Future<Either<Failure, void>> removeDoctorFromFavorites(String doctorId);
}
