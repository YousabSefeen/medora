import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;

class GetDoctorFavoriteStatusUseCase extends BaseUseCase<Set<String>, String> {
  final FavoritesRepositoryBase favoritesRepositoryBase;

  GetDoctorFavoriteStatusUseCase({required this.favoritesRepositoryBase});

  @override
  Future<Either<Failure, Set<String>>> call(String parameters) async {
    return await favoritesRepositoryBase.getDoctorFavoriteStatus(parameters);
  }
}
