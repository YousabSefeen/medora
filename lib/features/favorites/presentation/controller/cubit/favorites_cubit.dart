import 'package:dartz/dartz.dart' show Either;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/favorites/domain/usecases/get_favorite_ids_use_case.dart'
    show GetFavoriteIdsUseCase;
import 'package:medora/features/favorites/domain/usecases/get_favorites_doctors_use_case.dart'
    show GetFavoritesDoctorsUseCase;
import 'package:medora/features/favorites/domain/usecases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase;
import 'package:medora/features/favorites/domain/value_objects/toggle_favorite_parameters.dart'
    show ToggleFavoriteParameters;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;

import '../../../../../core/error/failure.dart' show Failure;

class FavoritesCubit extends BasePaginationCubit<DoctorEntity, FavoritesState> {
  final GetFavoriteIdsUseCase getFavoriteIdsUseCase;
  final GetFavoritesDoctorsUseCase getFavoritesDoctorsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoriteIdsUseCase,
    required this.getFavoritesDoctorsUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoritesState());

  /// Fetches the list of favorite doctor IDs.
  ///
  /// Purpose: Used to determine the state of the "heart" (Favorite) icon
  /// across the app (Home screen, Search results) without loading full doctor models.
  ///
  /// Performance: This is a lightweight request as it only retrieves a list of Strings,
  /// minimizing data usage and ensuring instant UI feedback.
  Future<void> fetchFavoriteIds() async {
    // Return early if IDs are already cached to prevent redundant network requests
    if (state.favoriteIds.isNotEmpty) return;

    final result = await getFavoriteIdsUseCase(const NoParams());
    result.fold(
      (failure) {
        AppLogger.error('Failed to fetch Favorite Ids', error: failure);
        emit(state.copyWith(idsLoadingState: RequestState.error));
      },
      (ids) => emit(
        state.copyWith(
          idsLoadingState: RequestState.loaded,
          favoriteIds: ids.toSet(),
        ),
      ),
    );
  }

  /// Implementation of the pagination logic for fetching detailed favorite doctor data.
  ///
  /// Purpose: Handles data loading for the FavoritesScreen.
  /// Pagination ensures we only load a small batch of doctors at a time,
  /// maintaining app performance and reducing Firestore read costs as the list grows.
  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> getUseCaseCall(
    PaginationParameters params,
  ) {
    return getFavoritesDoctorsUseCase.call(params);
  }

  /// Toggles a doctor's favorite status with Optimistic UI updates.
  Future<void> toggleFavorite({
    required bool isCurrentlyFavorite,
    required DoctorEntity doctorInfo,
  }) async {
    // 1. Apply optimistic update locally for instant UI response
    _applyOptimisticUpdates(isCurrentlyFavorite, doctorInfo);

    // 2. Perform the actual network request
    final result = await toggleFavoriteUseCase(
      ToggleFavoriteParameters(
        isCurrentlyFavorite: isCurrentlyFavorite,
        doctorId: doctorInfo.doctorId!,
      ),
    );

    // 3. Rollback the state if the network request fails
    result.fold((failure) {
      AppLogger.error('Failed to toggle favorite', error: failure);

      emit(state.copyWith(toggleState: RequestState.error));
      _rollbackUpdate(isCurrentlyFavorite, doctorInfo);
    }, (success) => emit(state.copyWith(toggleState: RequestState.loaded)));
  }

  /// Helper to update both the IDs set and the data list locally.
  void _applyOptimisticUpdates(bool isFavorite, DoctorEntity doctorInfo) {
    final updatedIds = Set<String>.from(state.favoriteIds);
    final updatedList = List<DoctorEntity>.from(state.dataList);

    if (isFavorite) {
      updatedIds.remove(doctorInfo.doctorId);
      updatedList.removeWhere((d) => d.doctorId == doctorInfo.doctorId);
    } else {
      updatedIds.add(doctorInfo.doctorId!);
      updatedList.insert(0, doctorInfo);
    }
    emit(state.copyWith(favoriteIds: updatedIds, dataList: updatedList));
  }

  /// Reverts the local changes if the server request fails.
  void _rollbackUpdate(bool originalIsFavorite, DoctorEntity doctorInfo) =>
      Future.delayed(
        AppDurations.milliseconds_500,
        () => _applyOptimisticUpdates(!originalIsFavorite, doctorInfo),
      );
}
