import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase, ToggleFavoriteParameters;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states_new.dart'
    show FavoritesStatesNew;

class FavoriteToggleCubit extends Cubit<FavoritesStatesNew> {
  ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoriteToggleCubit({required this.toggleFavoriteUseCase})
    : super(const FavoritesStatesNew());

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
      (success) => _updateFavoritesListAfterToggle(
        isFavorite: isFavorite,
        doctorInfo: doctorInfo,
      ),
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
