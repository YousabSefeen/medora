import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/app_settings/controller/states/app_settings_states.dart' show AppSettingsStates;
import 'package:medora/core/enum/internet_state.dart' show InternetState;


class AppSettingsCubit extends Cubit<AppSettingsStates> {
  AppSettingsCubit() : super(AppSettingsStates.initial());

  StreamSubscription<List<ConnectivityResult>>? _streamSubscription;

  ///  Initial check for current internet connectivity (only once)
  Future<void> checkInitialInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    _handleResult(result);
  }

   /// Starts monitoring internet connection changes (only triggers once)
  void startMonitoring() {
    // If a subscription is already active, do not create a new one
    if (_streamSubscription != null) return;

    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen(_handleResult);
  }

  ///  Stops the subscription when needed (important for clean-up)
  Future<void> stopMonitoring() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  ///   Internal handler to update the state based on the result
  void _handleResult(dynamic result) {
    // If the result is a List<ConnectivityResult> (as in the stream callback)
    final results = result is List<ConnectivityResult> ? result : [result];

    if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi)) {
      emit(state.copyWith(internetState: InternetState.connected));
    } else {
      emit(state.copyWith(internetState: InternetState.disconnected));
    }
  }

  @override
  Future<void> close() async {
    await stopMonitoring();
    return super.close();
  }
}
