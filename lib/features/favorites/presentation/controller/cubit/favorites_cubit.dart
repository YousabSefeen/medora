import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/favorites/data/repository/favorites_repository.dart'
    show FavoritesRepository;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;

class FavoritesCubit extends Cubit<FavoritesStates> {
  final FavoritesRepository favoritesRepository;

  FavoritesCubit({required this.favoritesRepository})
    : super(const FavoritesStates());

  Future<void> isDoctorFavorite({required String doctorId}) async {
    emit(state.copyWith(requestState: LazyRequestState.loading));
    final result = await favoritesRepository.isDoctorFavorite(doctorId);

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

  Future<void> _addDoctorToFavorites({required String doctorId}) async =>
      await favoritesRepository.addDoctorToFavorites(doctorId);

  Future<void> _removeDoctorFromFavorites({required String doctorId}) async =>
      await favoritesRepository.removeDoctorFromFavorites(doctorId);

  Future<void> toggleFavorite({
    required bool isFavorite,
    required String doctorId,
  }) async {
    final previousFavorites = _saveCurrentState();

    _performOptimisticUpdate(isFavorite: isFavorite, doctorId: doctorId);
    await _executeBackendOperation(isFavorite: isFavorite, doctorId: doctorId);
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
    required String doctorId,
  }) async {
    try {
      if (isFavorite) {
        await _removeDoctorFromFavorites(doctorId: doctorId);
      } else {
        await _addDoctorToFavorites(doctorId: doctorId);
      }
    } catch (error) {
      emit(
        state.copyWith(
          favoriteDoctors: _saveCurrentState(),
          updateFavoritesError: 'Failed to update favorites',
        ),
      );
    }
  }

  Future<void> getAllFavorites() async {
    final response = await favoritesRepository.getAllFavorites();

    response.fold(
      (failure) => emit(
        state.copyWith(
          favoritesListState: LazyRequestState.error,
          favoritesListError: failure.toString(),
        ),
      ),
      (doctors) {
        emit(
          state.copyWith(
            favoritesListState: LazyRequestState.loaded,
            favoritesList: doctors,
          ),
        );
      },
    );
  }
}
