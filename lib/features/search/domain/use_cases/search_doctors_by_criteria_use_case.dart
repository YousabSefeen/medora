import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/search/domain/entities/search_filters.dart'
    show SearchFilters;
import 'package:medora/features/search/domain/search_repository_base/search_repository_base.dart'
    show SearchRepositoryBase;

import '../../../../core/error/failure.dart' show Failure;

class SearchDoctorsByCriteriaUseCase
    extends BaseUseCase<List<DoctorModel>, SearchFilters> {
  final SearchRepositoryBase searchRepositoryBase;

  SearchDoctorsByCriteriaUseCase({required this.searchRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorModel>>> call(
    SearchFilters filters,
  ) async =>
      await searchRepositoryBase.searchDoctorsByCriteria(filters: filters);
}
