import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/register_controllers.dart' show RegisterControllers;


import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/user_type.dart';
import '../../../data/repository/auth_repository.dart';
import '../form_controllers/register_validator.dart';
import '../states/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  RegisterCubit({required this.authRepository})
      : super(RegisterState.initial());

  void togglePasswordVisibility() => emit(state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
      ));

  void toggleConfirmPasswordVisibility() => emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      ));

  void toggleUserType(UserType userType) => emit(state.copyWith(
        userType: userType,
      ));

  RegisterControllers? _cachedControllers;

  String? validateAndCacheInputs(RegisterControllers controllers) {
    final message = RegisterValidator().validateInputs(controllers);
    if (message == null) _cachedControllers = controllers;
    return message;
  }

  Future<void> register() async {
    if (_cachedControllers == null) return;
    final c = _cachedControllers!;
    emit(state.copyWith(registerState: LazyRequestState.loading));

    final response = await authRepository.register(
      name: c.userNameController.text,
      phone: c.phoneController.text,
      email: c.emailController.text,
      password: c.passwordController.text,
      role: state.userType.name,
    );

    response.fold(
        (failure) => emit(state.copyWith(
              registerState: LazyRequestState.error,
              error: failure.toString(),
            )),
        (success) => emit(state.copyWith(
              registerState: LazyRequestState.loaded,
            )));
  }

  void resetStates() => emit(RegisterState.initial());
}
