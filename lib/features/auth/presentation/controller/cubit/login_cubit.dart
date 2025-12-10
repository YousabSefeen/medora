import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enum/lazy_request_state.dart';
import '../../../data/repository/auth_repository.dart';
import '../form_controllers/login_controllers.dart';
import '../form_controllers/login_validator.dart';
import '../states/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginState.initial());

  void togglePasswordVisibility() =>
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));

  LoginControllers? _cachedControllers;

  String? validateAndCacheInputs(LoginControllers controllers) {
    final message = LoginValidator().validateInputs(controllers);
    if (message == null) _cachedControllers = controllers;
    return message;
  }

  Future<void> login() async {
    if (_cachedControllers == null) return;
    final c = _cachedControllers!;
    emit(state.copyWith(loginStatus: LazyRequestState.loading));

    final response = await authRepository.login(
      email: c.emailController.text,
      password: c.passwordController.text,
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          loginStatus: LazyRequestState.error,
          loginError: failure.toString(),
        ),
      ),
      (success) async =>
          emit(state.copyWith(loginStatus: LazyRequestState.loaded)),
    );
  }

  void resetStates() => emit(LoginState.initial());

  Future<void> logout() async => await authRepository.logout();
}
