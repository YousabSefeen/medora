import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/search/domain/search_repository_base/search_repository_base.dart'
    show SearchRepositoryBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

class SearchDoctorsByNameUseCase
    extends BaseUseCase<List<DoctorEntity>, String> {
  final SearchRepositoryBase searchRepositoryBase;

  SearchDoctorsByNameUseCase({required this.searchRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(String params) async {
    return await searchRepositoryBase.searchDoctorsByName(
      doctorName: params,
    );
  }
}
