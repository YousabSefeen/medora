import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class LoginState extends Equatable {
  final bool isPasswordVisible;
  final LazyRequestState loginStatus;
  final String? loginError;

  const LoginState({
    required this.isPasswordVisible,
    required this.loginStatus,
    required this.loginError,
  });

  factory LoginState.initial() {
    return const LoginState(
      isPasswordVisible: true,
      loginStatus: LazyRequestState.lazy,
      loginError: '',
    );
  }

  LoginState copyWith({
    bool? isPasswordVisible,
    LazyRequestState? loginStatus,
    String? loginError,
  }) => LoginState(
    isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    loginStatus: loginStatus ?? this.loginStatus,
    loginError: loginError ?? this.loginError,
  );

  @override
  List<Object?> get props => [isPasswordVisible, loginStatus, loginError];
}
