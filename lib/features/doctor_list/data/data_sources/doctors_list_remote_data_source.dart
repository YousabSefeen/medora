import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

abstract class DoctorsListRemoteDataSource {
  Future<PaginatedDataResponse<DoctorEntity>> getDoctorsList(
    PaginationParameters parameters,
  );
}
