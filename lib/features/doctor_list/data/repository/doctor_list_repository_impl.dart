import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/data/data_source/doctors_list_remote_data_source.dart'
    show DoctorsListRemoteDataSource;
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart'
    show DoctorListRepositoryBase;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class DoctorListRepositoryImpl extends DoctorListRepositoryBase {
  final DoctorsListRemoteDataSource dataSource;

  DoctorListRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> getDoctorsList(
      {
    required PaginationParameters parameters,
  }) async {
    try {
      final doctorList = await dataSource.getDoctorsList(parameters);
      return right(doctorList);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
