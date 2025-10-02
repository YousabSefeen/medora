import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

import '../../../../../core/enum/user_type.dart';

class RegisterState extends Equatable {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final UserType userType;
  final LazyRequestState registerState;
  final String? error;
  final bool isSendEmailVerification;
  final bool isAuthGoogle;

  const RegisterState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.userType,
    required this.registerState,
    required this.error,
    required this.isSendEmailVerification,
    required this.isAuthGoogle,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isPasswordVisible: true,
      isConfirmPasswordVisible: true,
      userType: UserType.client,
      registerState: LazyRequestState.lazy,
      error: null,
      isSendEmailVerification: false,
      isAuthGoogle: false,
    );
  }

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    UserType? userType,
    LazyRequestState? registerState,
    String? error,
    bool? isSendEmailVerification,
    bool? isAuthGoogle,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      userType: userType ?? this.userType,
      registerState: registerState ?? this.registerState,
      error: error,
      isSendEmailVerification:
          isSendEmailVerification ?? this.isSendEmailVerification,
      isAuthGoogle: isAuthGoogle ?? this.isAuthGoogle,
    );
  }

  @override
  List<Object?> get props => [
        isPasswordVisible,
        isConfirmPasswordVisible,
        userType,
        registerState,
        error,
        isSendEmailVerification,
        isAuthGoogle,
      ];
}
