import 'dart:async' show FutureOr;

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParameters;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/favorites/domain/use_cases/get_doctor_favorite_status_use_case.dart'
    show GetDoctorFavoriteStatusUseCase;
import 'package:medora/features/favorites/domain/use_cases/get_favorites_list_use_case.dart'
    show GetFavoritesListUseCase;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase, ToggleFavoriteParameters;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states_new.dart'
    show FavoritesStatesNew;

class FavoritesCubitNew extends Cubit<FavoritesStatesNew> {
  GetDoctorFavoriteStatusUseCase getDoctorFavoriteStatusUseCase;
  GetFavoritesListUseCase getFavoritesListUseCase;
  ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesCubitNew({
    required this.getDoctorFavoriteStatusUseCase,
    required this.getFavoritesListUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoritesStatesNew());

  FutureOr<void> getFavorites() async {
    final result = await getFavoritesListUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          favoritesListState: LazyRequestState.error,
          favoritesListError: l.toString(),
        ),
      ),
      (favoritesList) => emit(
        state.copyWith(
          favoritesList: favoritesList,
          favoritesListState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> getDoctorFavoriteStatus({required String doctorId}) async {
    final result = await getDoctorFavoriteStatusUseCase(doctorId);

    result.fold(
      (failure) => emit(state.copyWith(requestState: LazyRequestState.error)),
      (favoriteDoctors) => emit(
          state.copyWith(
            requestState: LazyRequestState.loaded,
            favoriteDoctors: favoriteDoctors,
          ),
        ),
    );
  }

  Future<void> toggleFavorite({
    required bool isFavorite,
    required DoctorModel doctorInfo,
  }) async {
    // 1. Apply UI updates immediately
    _applyOptimisticUpdates(isFavorite, doctorInfo);

    // 2. Execute backend operation
    final result = await toggleFavoriteUseCase(
      ToggleFavoriteParameters(
        isCurrentlyFavorite: isFavorite,
        doctorId: doctorInfo.doctorId!,
      ),
    );

    // 3. Handle result
    result.fold(
      (failure) => _rollbackWithDelay(isFavorite, doctorInfo),
      (success) => _onToggleSuccess(isFavorite, doctorInfo),
    );
  }

  void _onToggleSuccess(bool isFavorite, DoctorModel doctorInfo) =>
      print('Favorite toggle succeeded ');

  void _applyOptimisticUpdates(bool isFavorite, DoctorModel doctorInfo) {
    _updateFavoriteDoctorsSet(isFavorite, doctorInfo.doctorId!);
    _updateFavoritesList(isFavorite, doctorInfo);
  }

  void _updateFavoriteDoctorsSet(bool isFavorite, String doctorId) {
    final updatedFavorites = Set<String>.from(state.favoriteDoctors);

    if (isFavorite) {
      updatedFavorites.remove(doctorId);
    } else {
      updatedFavorites.add(doctorId);
    }

    emit(state.copyWith(favoriteDoctors: updatedFavorites));
  }

  void _updateFavoritesList(bool isFavorite, DoctorModel doctorInfo) {
    final updatedFavoritesList = List<DoctorModel>.from(state.favoritesList);

    final index = updatedFavoritesList.indexWhere(
      (doctor) => doctor.doctorId == doctorInfo.doctorId,
    );

    if (index != -1 && isFavorite) {
      updatedFavoritesList.removeAt(index);
    } else {
      updatedFavoritesList.insert(0, doctorInfo);
    }

    emit(state.copyWith(favoritesList: updatedFavoritesList));
  }

  void _rollbackWithDelay(bool originalState, DoctorModel doctorInfo) =>
      Future.delayed(
        const Duration(milliseconds: 500),
        () => _applyOptimisticUpdates(!originalState, doctorInfo),
      );
}

/*
import 'dart:async' show FutureOr;

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParameters;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/favorites/domain/use_cases/get_doctor_favorite_status_use_case.dart'
    show GetDoctorFavoriteStatusUseCase;
import 'package:medora/features/favorites/domain/use_cases/get_favorites_list_use_case.dart'
    show GetFavoritesListUseCase;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase, ToggleFavoriteParameters;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states_new.dart'
    show FavoritesStatesNew;

class FavoritesCubitNew extends Cubit<FavoritesStatesNew> {
  GetDoctorFavoriteStatusUseCase getDoctorFavoriteStatusUseCase;
  GetFavoritesListUseCase getFavoritesListUseCase;
  ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesCubitNew({
    required this.getDoctorFavoriteStatusUseCase,
    required this.getFavoritesListUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoritesStatesNew());

  FutureOr<void> getFavorites() async {
    final result = await getFavoritesListUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          favoritesListState: LazyRequestState.error,
          favoritesListError: l.toString(),
        ),
      ),
      (favoritesList) => emit(
        state.copyWith(
          favoritesList: favoritesList,
          favoritesListState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> getDoctorFavoriteStatus({required String doctorId}) async {
    final result = await getDoctorFavoriteStatusUseCase(doctorId);

    result.fold(
      (failure) => emit(state.copyWith(requestState: LazyRequestState.error)),
      (favoriteDoctors) {
        emit(
          state.copyWith(
            requestState: LazyRequestState.loaded,
            favoriteDoctors: favoriteDoctors,
          ),
        );
      },
    );
  }

  /// New
  Future<void> toggleFavorite({
    required bool isFavorite,
    required DoctorModel doctorInfo,
  }) async {
    final previousFavorites = _saveCurrentState();

    _performOptimisticUpdate(
      isFavorite: isFavorite,
      doctorId: doctorInfo.doctorId!,
    );
    await _executeBackendOperation(
      isFavorite: isFavorite,
      doctorInfo: doctorInfo,
    );
  }

  Set<String> _saveCurrentState() => Set<String>.from(state.favoriteDoctors);

  //   Responsibility: Update the UI immediately
  void _performOptimisticUpdate({
    required bool isFavorite,
    required String doctorId,
  }) {
    final updatedFavorites = Set<String>.from(state.favoriteDoctors);

    if (isFavorite) {
      updatedFavorites.remove(doctorId);
    } else {
      updatedFavorites.add(doctorId);
    }

    emit(state.copyWith(favoriteDoctors: updatedFavorites));
  }

  //   Responsibility: Execute the process in the background
  Future<void> _executeBackendOperation({
    required bool isFavorite,
    required DoctorModel doctorInfo,
  }) async {
    final result = await toggleFavoriteUseCase(
      ToggleFavoriteParameters(
        isCurrentlyFavorite: isFavorite,
        doctorId: doctorInfo.doctorId!,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          favoriteDoctors: _saveCurrentState(),
          updateFavoritesError: 'Failed to update favorites',
        ),
      ),
      (success) {
        _updateFavoritesListAfterToggle(
        isFavorite: isFavorite,
        doctorInfo: doctorInfo,
      );
      },
    );
  }

  void _updateFavoritesListAfterToggle({
    required bool isFavorite,
    required DoctorModel doctorInfo,
  }) {
    final updatedFavoritesList = List<DoctorModel>.from(state.favoritesList);

    final index = updatedFavoritesList.indexWhere(
      (doctor) => doctor.doctorId == doctorInfo.doctorId,
    );

    if (index != -1 && isFavorite) {
      updatedFavoritesList.removeAt(index);
    } else {
      updatedFavoritesList.insert(0, doctorInfo);
    }

    emit(state.copyWith(favoritesList: updatedFavoritesList));
  }
}

 */
