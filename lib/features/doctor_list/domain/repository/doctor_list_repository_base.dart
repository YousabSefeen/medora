import 'package:dartz/dartz.dart' show Either;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

import '../../../../core/error/failure.dart' show Failure;

abstract class DoctorListRepositoryBase {
  Future<Either<Failure, PaginatedDataResponse>> getDoctorsList(
    PaginationParameters parameters,
  );
}
