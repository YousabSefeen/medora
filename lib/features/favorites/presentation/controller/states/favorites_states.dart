import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

/*class FavoritesStates extends Equatable {
  final LazyRequestState favoritesListState;
  final String favoritesListError;
  final List<DoctorEntity> favoritesDoctorsList;
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
    List<DoctorEntity>? favoritesDoctorsList,
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
}*/
class FavoritesStates extends Equatable {
  // للتحكم في جلب الـ IDs
  final LazyRequestState idsLoadingState;
  final Set<String> favoriteIds;

  // للتحكم في جلب قائمة الأطباء المفضلة بالكامل
  final LazyRequestState listLoadingState;
  final String listError;
  final List<DoctorEntity> favoriteDoctors;

  // للتحكم في عملية التبديل (Toggle)
  final LazyRequestState toggleState;
  final String toggleError;

  const FavoritesStates({
    this.idsLoadingState = LazyRequestState.loading,
    this.favoriteIds = const {},
    this.listLoadingState = LazyRequestState.loading,
    this.listError = '',
    this.favoriteDoctors = const [],
    this.toggleState = LazyRequestState.loaded,
    this.toggleError = '',
  });

  FavoritesStates copyWith({
    LazyRequestState? idsLoadingState,
    Set<String>? favoriteIds,
    LazyRequestState? listLoadingState,
    String? listError,
    List<DoctorEntity>? favoriteDoctors,
    LazyRequestState? toggleState,
    String? toggleError,
  }) {
    return FavoritesStates(
      idsLoadingState: idsLoadingState ?? this.idsLoadingState,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      listLoadingState: listLoadingState ?? this.listLoadingState,
      listError: listError ?? this.listError,
      favoriteDoctors: favoriteDoctors ?? this.favoriteDoctors,
      toggleState: toggleState ?? this.toggleState,
      toggleError: toggleError ?? this.toggleError,
    );
  }

  @override
  List<Object?> get props => [
    idsLoadingState, favoriteIds, listLoadingState, listError,
    favoriteDoctors, toggleState, toggleError,
  ];
}