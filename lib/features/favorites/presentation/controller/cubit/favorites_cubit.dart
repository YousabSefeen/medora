import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/favorites/domain/use_cases/get_favorites_doctors_use_case.dart'
    show GetFavoritesDoctorsUseCase;
import 'package:medora/features/favorites/domain/use_cases/is_doctor_favorite_use_case.dart'
    show IsDoctorFavoriteUseCase;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase;
import 'package:medora/features/favorites/domain/value_objects/toggle_favorite_parameters.dart'
    show ToggleFavoriteParameters;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;

import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

import '../../../../../core/error/failure.dart' show Failure;

class FavoritesCubit extends Cubit<FavoritesStates> {
  final IsDoctorFavoriteUseCase isDoctorFavoriteUseCase;
  final GetFavoritesDoctorsUseCase getFavoritesDoctorsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesCubit({
    required this.isDoctorFavoriteUseCase,
    required this.getFavoritesDoctorsUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoritesStates());

  Future<void> getFavoritesDoctors() async {
    final result = await getFavoritesDoctorsUseCase(const NoParams());

    result.fold(
      (failure) => _handleFavoritesListError(failure),
      (favoritesList) => _handleFavoritesListSuccess(favoritesList),
    );
  }

  void _handleFavoritesListError(Failure failure) => emit(
    state.copyWith(
      favoritesListState: LazyRequestState.error,
      favoritesListError: failure.toString(),
    ),
  );

  void _handleFavoritesListSuccess(List<DoctorEntity> favoritesList) => emit(
    state.copyWith(
      favoritesDoctorsList: favoritesList,
      favoritesListState: LazyRequestState.loaded,
    ),
  );

  Future<void> checkDoctorFavoriteStatus({required String doctorId}) async {
    final result = await isDoctorFavoriteUseCase(doctorId);

    result.fold(
      (failure) => _handleFavoriteCheckError(failure),
      (isFavorite) => _handleFavoriteCheckSuccess(doctorId, isFavorite),
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

    result.fold(
      (failure) => _onToggleFailure(isFavorite, doctorInfo),
      (success) => _onToggleSuccess(isFavorite, doctorInfo),
    );
  }

  void _onToggleFailure(bool isFavorite, DoctorEntity doctorInfo) {
    emit(
      state.copyWith(
        toggleFavoriteState: LazyRequestState.error,
        toggleFavoriteError: AppStrings.toggleFavoriteErrorMsg,
      ),
    );
    _rollbackWithDelay(isFavorite, doctorInfo);
  }

  // ========== PRIVATE METHODS ========== //

  void _applyOptimisticUpdates(bool isFavorite, DoctorEntity doctorInfo) {
    final updatedFavorites = _updateFavoriteDoctorsSet(
      doctorId: doctorInfo.doctorId!,
      shouldBeFavorite: !isFavorite,
    );

    final updatedList = _getUpdatedFavoritesList(
      isFavorite: isFavorite,
      doctorInfo: doctorInfo,
    );

    emit(
      state.copyWith(
        favoriteDoctorsSet: updatedFavorites,
        favoritesDoctorsList: updatedList,
      ),
    );
  }

  Set<String> _updateFavoriteDoctorsSet({
    required String doctorId,
    required bool shouldBeFavorite,
  }) {
    final updated = Set<String>.from(state.favoriteDoctorsSet);

    if (shouldBeFavorite) {
      updated.add(doctorId);
    } else {
      updated.remove(doctorId);
    }

    return updated;
  }

  /// Get the updated favorites list
  List<DoctorEntity> _getUpdatedFavoritesList({
    required bool isFavorite,
    required DoctorEntity doctorInfo,
  }) {
    final updatedList = List<DoctorEntity>.from(state.favoritesDoctorsList);
    final index = updatedList.indexWhere(
      (doctor) => doctor.doctorId == doctorInfo.doctorId,
    );

    if (isFavorite) {
      if (index != -1) {
        updatedList.removeAt(index);
      }
    } else {
      if (index == -1) {
        updatedList.insert(0, doctorInfo);
      }
    }

    return updatedList;
  }

  /// Rolling back updates after a delay period
  void _rollbackWithDelay(bool originalState, DoctorEntity doctorInfo) =>
      Future.delayed(
        AppDurations.milliseconds_500,
        () => _applyOptimisticUpdates(!originalState, doctorInfo),
      );

  /// Handling the successful switch to the favorites
  void _onToggleSuccess(bool isFavorite, DoctorEntity doctorInfo) =>
      emit(state.copyWith(toggleFavoriteState: LazyRequestState.loaded));

  /// Handling favorites verification errors
  void _handleFavoriteCheckError(Failure failure) => emit(
    state.copyWith(
      requestState: LazyRequestState.error,

      /// error: failure.message,
    ),
  );

  void _handleFavoriteCheckSuccess(String doctorId, bool isFavorite) {
    final updatedFavorites = _updateFavoriteDoctorsSet(
      doctorId: doctorId,
      shouldBeFavorite: isFavorite,
    );

    emit(
      state.copyWith(
        requestState: LazyRequestState.loaded,
        favoriteDoctorsSet: updatedFavorites,
      ),
    );
  }
}
