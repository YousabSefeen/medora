import 'package:dartz/dartz.dart' show Either, right, left;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/search/data/data_sources/search_remote_data_source.dart'
    show SearchRemoteDataSourceBase;
import 'package:medora/features/search/domain/entities/search_filters.dart'
    show SearchFilters;
import 'package:medora/features/search/domain/search_repository_base/search_repository_base.dart'
    show SearchRepositoryBase;
import 'package:medora/features/search/domain/value_objects/search_filters/location_filter.dart'
    show LocationFilter;
import 'package:medora/features/search/domain/value_objects/search_filters/name_filter.dart';
import 'package:medora/features/search/domain/value_objects/search_filters/price_range_filter.dart';
import 'package:medora/features/search/domain/value_objects/search_filters/specialty_filter.dart'
    show SpecialtyFilter;

import '../../../../core/error/failure.dart' show ServerFailure, Failure;

class SearchRepositoryImpl extends SearchRepositoryBase {
  final SearchRemoteDataSourceBase _dataSource;

  SearchRepositoryImpl({required SearchRemoteDataSourceBase dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByName({
    required String doctorName,
  }) async {
    try {
      final filters = [NameFilter(doctorName)];

      final doctorsList = await _dataSource.searchDoctors(filters);

      return right(doctorsList);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByCriteria({
    required SearchFilters filters,
  }) async {
    try {
      final searchFilters = [
        NameFilter(filters.doctorName),
        PriceRangeFilter(filters.priceRange),
        if (filters.specialties.isNotEmpty)
          SpecialtyFilter(filters.specialties),
        if (filters.location != null && filters.location!.isNotEmpty)
          LocationFilter(filters.location!),
      ];

      final List doctorsList = await _dataSource.searchDoctors(searchFilters);
      return right(doctorsList as List<DoctorModel>);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
