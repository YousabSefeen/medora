import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/repositories/favorites_repository.dart'
    show FavoritesRepository;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/domain/use_cases/base_pagination_use_case.dart'
    show BasePaginationUseCase;

class GetFavoritesDoctorsUseCase extends BasePaginationUseCase<DoctorEntity> {
  final FavoritesRepository favoritesRepository;

  GetFavoritesDoctorsUseCase({required this.favoritesRepository});

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> call(
    PaginationParameters email,
  ) async {
    return await favoritesRepository.getFavoritesDoctors(
      parameters: email,
    );
  }
}
