import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';

import '../entities/specialty_entity.dart';
import '../repositories/specialties_repository.dart';

class FetchAllSpecialtiesUseCase
    extends BaseUseCase<List<SpecialtyEntity>, NoParams> {
  final SpecialtiesRepository _specialtiesRepository;

  FetchAllSpecialtiesUseCase({required this._specialtiesRepository});

  @override
  Future<Either<Failure, List<SpecialtyEntity>>> call(NoParams params) async {
    return await _specialtiesRepository.fetchAllSpecialties();
  }
}
