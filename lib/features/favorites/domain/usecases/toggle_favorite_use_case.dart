import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/repositories/favorites_repository.dart'
    show FavoritesRepository;
import 'package:medora/features/favorites/domain/value_objects/toggle_favorite_parameters.dart'
    show ToggleFavoriteParameters;

class ToggleFavoriteUseCase
    extends BaseUseCase<void, ToggleFavoriteParameters> {
  final FavoritesRepository favoritesRepository;

  ToggleFavoriteUseCase({required this.favoritesRepository});

  @override
  Future<Either<Failure, void>> call(ToggleFavoriteParameters email) async {
    if (email.isCurrentlyFavorite) {
      return await favoritesRepository.removeDoctorFromFavorites(
        email.doctorId,
      );
    } else {
      return await favoritesRepository.addDoctorToFavorites(email.doctorId);
    }
  }
}
