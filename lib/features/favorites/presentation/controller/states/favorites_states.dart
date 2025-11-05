import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class FavoritesStates extends Equatable {
  final LazyRequestState favoritesListState;
  final String favoritesListError;
  final List<DoctorModel> favoritesDoctorsList;
  final Set<String> favoriteDoctorsSet;

  final LazyRequestState toggleFavoriteState;
  final String toggleFavoriteError;
  final LazyRequestState requestState;

  const FavoritesStates({
    this.favoritesListState = LazyRequestState.loading,
    this.favoritesListError = '',
    this.favoritesDoctorsList = const [],
    this.favoriteDoctorsSet = const {},
    this.toggleFavoriteState = LazyRequestState.loading,
    this.toggleFavoriteError = '',
    this.requestState = LazyRequestState.lazy,
  });

  FavoritesStates copyWith({
    LazyRequestState? favoritesListState,
    String? favoritesListError,
    List<DoctorModel>? favoritesDoctorsList,
    Set<String>? favoriteDoctorsSet,

    LazyRequestState? toggleFavoriteState,
    String? toggleFavoriteError,
    LazyRequestState? requestState,
  }) {
    return FavoritesStates(
      favoritesListState: favoritesListState ?? this.favoritesListState,
      favoritesListError: favoritesListError ?? this.favoritesListError,
      favoritesDoctorsList: favoritesDoctorsList ?? this.favoritesDoctorsList,
      favoriteDoctorsSet: favoriteDoctorsSet ?? this.favoriteDoctorsSet,

      toggleFavoriteState: toggleFavoriteState ?? this.toggleFavoriteState,
      toggleFavoriteError: toggleFavoriteError ?? this.toggleFavoriteError,
      requestState: requestState ?? this.requestState,
    );
  }

  @override
  List<Object?> get props => [
    favoritesListState,
    favoritesListError,
    favoritesDoctorsList,
    favoriteDoctorsSet,
    toggleFavoriteState,
    toggleFavoriteError,
    requestState,
  ];
}
