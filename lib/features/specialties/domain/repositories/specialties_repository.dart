import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../shared/domain/entities/doctor_entity.dart';
import '../../../shared/domain/entities/paginated_data_response.dart';
import '../entities/specialty_entity.dart';
import '../params/fetch_doctors_by_specialty_params.dart';

abstract class SpecialtiesRepository {
  Future<Either<Failure, List<SpecialtyEntity>>> fetchAllSpecialties();

  Future<Either<Failure, List<SpecialtyEntity>>> fetchTopSpecialties();

  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>>
  fetchDoctorsBySpecialty({required GetDoctorsBySpecialtyParameters parameters});
}
