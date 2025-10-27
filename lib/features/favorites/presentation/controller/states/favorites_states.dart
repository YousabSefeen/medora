import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class FavoritesStates extends Equatable {
  final LazyRequestState favoritesListState;
  final String favoritesListError;
  final List<DoctorModel> favoritesList;

  final Set<String> favoriteDoctors;
  final String updateFavoritesError;
  final LazyRequestState requestState;

  const FavoritesStates({
    this.favoritesListState = LazyRequestState.loading,
    this.favoritesListError = '',
    this.favoritesList = const [],

    this.favoriteDoctors = const {},
    this.updateFavoritesError = '',
    this.requestState = LazyRequestState.lazy,
  });

  FavoritesStates copyWith({
    LazyRequestState? favoritesListState,
    String? favoritesListError,
    List<DoctorModel>? favoritesList,

    Set<String>? favoriteDoctors,
    String? updateFavoritesError,
    LazyRequestState? requestState,
  }) {
    return FavoritesStates(
      favoritesListState: favoritesListState ?? this.favoritesListState,
      favoritesListError: favoritesListError ?? this.favoritesListError,
      favoritesList: favoritesList ?? this.favoritesList,

      favoriteDoctors: favoriteDoctors ?? this.favoriteDoctors,
      updateFavoritesError: updateFavoritesError ?? this.updateFavoritesError,
      requestState: requestState ?? this.requestState,
    );
  }

  @override
  List<Object?> get props => [
    favoritesListState,
    favoritesListError,
    favoritesList,

    favoriteDoctors,
    updateFavoritesError,
    requestState,
  ];
}
