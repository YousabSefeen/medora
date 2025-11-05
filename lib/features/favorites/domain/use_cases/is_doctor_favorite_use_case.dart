import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;

class IsDoctorFavoriteUseCase extends BaseUseCase<bool, String> {
  final FavoritesRepositoryBase favoritesRepositoryBase;

  IsDoctorFavoriteUseCase({required this.favoritesRepositoryBase});

  @override
  Future<Either<Failure, bool>> call(String doctorId) async {
    return await favoritesRepositoryBase.isDoctorFavorite(doctorId);
  }
}
