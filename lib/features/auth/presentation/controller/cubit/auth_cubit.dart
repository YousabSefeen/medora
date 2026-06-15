import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/features/auth/domain/params/sign_in_params.dart'
    show SignInParams;
import 'package:medora/features/auth/domain/params/sign_up_params.dart'
    show SignUpParams;
import 'package:medora/features/auth/domain/use_cases/get_user_id_use_case.dart'
    show GetUserIdUseCase;
import 'package:medora/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;

  final SignOutUseCase _signOutUseCase;
  final GetUserIdUseCase _getUserIdUseCase;

  AuthCubit({
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,

    required SignOutUseCase signOutUseCase,
    required GetUserIdUseCase getUserIdUseCase,
  }) : _signUpUseCase = signUpUseCase,
       _signInUseCase = signInUseCase,
       _signOutUseCase = signOutUseCase,
       _getUserIdUseCase = getUserIdUseCase,
       super(AuthInitial());
  Future<void> signUp(SignUpParams params) async {
    emit(AuthLoading());

    final result = await _signUpUseCase(params);

    result.fold((failure) {
      emit(AuthFailure(failure.errorMessage));
    }, (_) => emit(SignUpSuccess()));
  }
  Future<void> signIn(SignInParams params) async {
    emit(AuthLoading());

    final result = await _signInUseCase(params);

    result.fold((failure) {
      emit(AuthFailure(failure.errorMessage));
    }, (_) => emit(SignInSuccess()));
  }



  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await _signOutUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.errorMessage)),
      (_) => emit(Unauthenticated()),
    );
  }
}
