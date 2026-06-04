import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

abstract class FavoritesRemoteDataSource {
  Future<List<String>> getFavoriteIds();

  Future<PaginatedDataResponse> getFavoritesDoctors(
    PaginationParameters parameters,
  );

  Future<void> addDoctorToFavorites(String doctorId);

  Future<void> removeDoctorFromFavorites(String doctorId);
}
