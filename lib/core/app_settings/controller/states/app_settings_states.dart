import 'package:equatable/equatable.dart';

import '../../../enum/internet_state.dart';

class AppSettingsStates extends Equatable {
  final InternetState internetState;

  const AppSettingsStates({
    required this.internetState,
  });

  factory AppSettingsStates.initial() {
    return const AppSettingsStates(
      internetState: InternetState.none,
    );
  }

  AppSettingsStates copyWith({
    InternetState? internetState,
  }) =>
      AppSettingsStates(
        internetState: internetState ?? this.internetState,
      );

  @override
  List<Object?> get props => [
        internetState,
      ];
}
