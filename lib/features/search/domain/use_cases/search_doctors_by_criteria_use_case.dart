import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/features/search/domain/entities/search_filters.dart'
    show SearchFilters;
import 'package:medora/features/search/domain/search_repository_base/search_repository_base.dart'
    show SearchRepositoryBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

import '../../../../core/error/failure.dart' show Failure;

class SearchDoctorsByCriteriaUseCase
    extends BaseUseCase<List<DoctorEntity>, SearchFilters> {
  final SearchRepositoryBase searchRepositoryBase;

  SearchDoctorsByCriteriaUseCase({required this.searchRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(
    SearchFilters params,
  ) async =>
      await searchRepositoryBase.searchDoctorsByCriteria(filters: params);
}
