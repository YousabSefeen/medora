import 'package:equatable/equatable.dart' show Equatable;

class ToggleFavoriteParameters extends Equatable {
  final bool isCurrentlyFavorite;
  final String doctorId;

  const ToggleFavoriteParameters({
    required this.isCurrentlyFavorite,
    required this.doctorId,
  });

  @override
  List<Object> get props => [isCurrentlyFavorite, doctorId];
}
