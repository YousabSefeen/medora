import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;

import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

class GetFavoritesDoctorsUseCase
    extends BaseUseCase<List<DoctorEntity>, NoParams> {
  final FavoritesRepositoryBase favoritesRepositoryBase;

  GetFavoritesDoctorsUseCase({required this.favoritesRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(
    NoParams params,
  ) async {
    return await favoritesRepositoryBase.getFavoritesDoctors();
  }
}
