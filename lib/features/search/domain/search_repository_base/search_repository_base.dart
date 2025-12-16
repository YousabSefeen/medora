import 'package:dartz/dartz.dart' show Either;
import 'package:medora/features/search/domain/entities/search_filters.dart'
    show SearchFilters;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

import '../../../../core/error/failure.dart' show Failure;

abstract class SearchRepositoryBase {
  Future<Either<Failure, List<DoctorEntity>>> searchDoctorsByName({
    required String doctorName,
  });

  Future<Either<Failure, List<DoctorEntity>>> searchDoctorsByCriteria({
    required SearchFilters filters,
  });
}
