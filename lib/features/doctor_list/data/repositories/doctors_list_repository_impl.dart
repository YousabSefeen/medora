import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/data/data_sources/doctors_list_remote_data_source.dart'
    show DoctorsListRemoteDataSource;
import 'package:medora/features/doctor_list/domain/repositories/doctors_list_repository.dart'
    show DoctorsListRepository;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class DoctorsListRepositoryImpl extends DoctorsListRepository {
  final DoctorsListRemoteDataSource _remoteDataSource;

  DoctorsListRepositoryImpl({
    required DoctorsListRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> getDoctorsList({
    required PaginationParameters parameters,
  }) async {
    try {
      final doctorList = await _remoteDataSource.getDoctorsList(parameters);
      return right(doctorList);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
