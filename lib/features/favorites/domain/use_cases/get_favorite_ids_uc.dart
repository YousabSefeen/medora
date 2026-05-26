import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;

class GetFavoriteIdsUc extends BaseUseCase<List<String>, NoParams> {
  final FavoritesRepositoryBase favoritesRepositoryBase;

  GetFavoriteIdsUc({required this.favoritesRepositoryBase});

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await favoritesRepositoryBase.getFavoriteIds();
  }
}
