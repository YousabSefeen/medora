import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/favorites/domain/repositories/favorites_repository.dart'
    show FavoritesRepository;

class GetFavoriteIdsUseCase extends BaseUseCase<List<String>, NoParams> {
  final FavoritesRepository favoritesRepository;

  GetFavoriteIdsUseCase({required this.favoritesRepository});

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await favoritesRepository.getFavoriteIds();
  }
}
