import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;
import 'package:medora/features/favorites/domain/value_objects/toggle_favorite_parameters.dart'
    show ToggleFavoriteParameters;

class ToggleFavoriteUseCase
    extends BaseUseCase<void, ToggleFavoriteParameters> {
  final FavoritesRepositoryBase favoritesRepositoryBase;

  ToggleFavoriteUseCase({required this.favoritesRepositoryBase});

  @override
  Future<Either<Failure, void>> call(
    ToggleFavoriteParameters parameters,
  ) async {
    if (parameters.isCurrentlyFavorite) {
      return await favoritesRepositoryBase.removeDoctorFromFavorites(
        parameters.doctorId,
      );
    } else {
      return await favoritesRepositoryBase.addDoctorToFavorites(
        parameters.doctorId,
      );
    }
  }
}
