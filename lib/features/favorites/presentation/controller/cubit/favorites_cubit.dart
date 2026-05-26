import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/favorites/domain/use_cases/get_favorite_ids_uc.dart'
    show GetFavoriteIdsUc;
import 'package:medora/features/favorites/domain/use_cases/get_favorites_doctors_use_case.dart'
    show GetFavoritesDoctorsUseCase;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase;
import 'package:medora/features/favorites/domain/value_objects/toggle_favorite_parameters.dart'
    show ToggleFavoriteParameters;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class FavoritesCubit extends Cubit<FavoritesStates> {
  final GetFavoritesDoctorsUseCase getFavoritesDoctorsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final GetFavoriteIdsUc getFavoriteIdsUc;

  FavoritesCubit({
    required this.getFavoritesDoctorsUseCase,
    required this.toggleFavoriteUseCase,
    required this.getFavoriteIdsUc,
  }) : super(const FavoritesStates());

  Future<void> fetchFavoriteIds() async {
    // Prevent redundant network requests if data is already cached
    if (state.favoriteIds.isNotEmpty) return;

    final result = await getFavoriteIdsUc(const NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(idsLoadingState: LazyRequestState.error)),
      (ids) => emit(
        state.copyWith(
          idsLoadingState: LazyRequestState.loaded,
          favoriteIds: ids.toSet(),
        ),
      ),
    );
  }

  Future<void> getFavoritesDoctors() async {
    emit(state.copyWith(listLoadingState: LazyRequestState.loading));
    final result = await getFavoritesDoctorsUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          listLoadingState: LazyRequestState.error,
          listError: failure.toString(),
        ),
      ),
      (list) => emit(
        state.copyWith(
          listLoadingState: LazyRequestState.loaded,
          favoriteDoctors: list,
        ),
      ),
    );
  }

  Future<void> toggleFavorite({
    required bool isFavorite,
    required DoctorEntity doctorInfo,
  }) async {
    _applyOptimisticUpdates(isFavorite, doctorInfo);

    final result = await toggleFavoriteUseCase(
      ToggleFavoriteParameters(
        isCurrentlyFavorite: isFavorite,
        doctorId: doctorInfo.doctorId!,
      ),
    );

    result.fold((failure) {
      emit(
        state.copyWith(
          toggleState: LazyRequestState.error,
          toggleError: AppStrings.toggleFavoriteErrorMsg,
        ),
      );
      _rollbackUpdate(isFavorite, doctorInfo);
    }, (success) => emit(state.copyWith(toggleState: LazyRequestState.loaded)));
  }

  void clearToggleState() =>
      emit(state.copyWith(toggleState: LazyRequestState.lazy));

  // ========== PRIVATE LOGIC ========== //

  void _applyOptimisticUpdates(bool isFavorite, DoctorEntity doctorInfo) {
    final updatedIds = Set<String>.from(state.favoriteIds);
    if (isFavorite) {
      updatedIds.remove(doctorInfo.doctorId);
    } else {
      updatedIds.add(doctorInfo.doctorId!);
    }

    final updatedList = List<DoctorEntity>.from(state.favoriteDoctors);
    if (isFavorite) {
      updatedList.removeWhere((d) => d.doctorId == doctorInfo.doctorId);
    } else {
      updatedList.insert(0, doctorInfo);
    }

    emit(state.copyWith(favoriteIds: updatedIds, favoriteDoctors: updatedList));
  }

  void _rollbackUpdate(bool originalIsFavorite, DoctorEntity doctorInfo) =>
      Future.delayed(
        AppDurations.milliseconds_500,
        () => _applyOptimisticUpdates(!originalIsFavorite, doctorInfo),
      );
}
