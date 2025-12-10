import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParameters;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

class GetFavoritesDoctorsUseCase
    extends BaseUseCase<List<DoctorModel>, NoParameters> {
  final FavoritesRepositoryBase favoritesRepositoryBase;

  GetFavoritesDoctorsUseCase({required this.favoritesRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorModel>>> call(
    NoParameters parameters,
  ) async {
    return await favoritesRepositoryBase.getFavoritesDoctors();
  }
}
