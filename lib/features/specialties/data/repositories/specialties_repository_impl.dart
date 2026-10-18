import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart';
import 'package:medora/features/specialties/domain/entities/specialty_entity.dart';

import '../../domain/params/fetch_doctors_by_specialty_params.dart';
import '../../domain/repositories/specialties_repository.dart';
import '../data_sources/specialties_local_data_source.dart';
import '../data_sources/specialties_remote_data_source.dart';

class SpecialtiesRepositoryImpl extends SpecialtiesRepository {
  final SpecialtiesLocalDataSource localDataSource;
  final SpecialtiesRemoteDataSource remoteDataSource;

  SpecialtiesRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<SpecialtyEntity>>> fetchAllSpecialties() async {
    try {
      final models = localDataSource.getAllSpecialties();
      return right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, List<SpecialtyEntity>>> fetchTopSpecialties() async {
    try {
      final models = localDataSource.getTopSpecialties();
      return right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>>
  fetchDoctorsBySpecialty({
    required GetDoctorsBySpecialtyParameters parameters,
  }) async {
    try {
      final result = await remoteDataSource.fetchDoctorsBySpecialty(parameters);
      return right(result);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
