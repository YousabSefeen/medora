import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart';

class FavoritesStates extends Equatable {
  final Set<String> favoriteDoctors;
  final String  updateFavoritesError;
  final LazyRequestState requestState;

  const FavoritesStates({
    this.favoriteDoctors = const {},
    this.updateFavoritesError ='' ,
    this.requestState = LazyRequestState.lazy,
  });

  FavoritesStates copyWith({
    Set<String>? favoriteDoctors,
    String? updateFavoritesError,
    LazyRequestState? requestState,
  }) {
    return FavoritesStates(
      favoriteDoctors: favoriteDoctors ?? this.favoriteDoctors,
      updateFavoritesError: updateFavoritesError ?? this.updateFavoritesError,
      requestState: requestState ?? this.requestState,
    );
  }

  @override
  List<Object?> get props => [favoriteDoctors, updateFavoritesError, requestState];
}
