
import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/auth_provider_type.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

// ==================== [ General Auth States ] ====================
final class AuthLoading extends AuthState {
  final AuthProviderType providerType;

  const AuthLoading(this.providerType);

  @override
  List<Object?> get props => [providerType];
}

final class AuthSuccess extends AuthState {
  final AuthProviderType providerType;

  const AuthSuccess(this.providerType);

  @override
  List<Object?> get props => [providerType];
}

final class AuthFailure extends AuthState {
  final AuthProviderType providerType;
  final String errorMessage;

  const AuthFailure({required this.providerType, required this.errorMessage});

  @override
  List<Object?> get props => [providerType, errorMessage];
}

// ==================== [ Sign Out States ] ====================
final class SignOutLoading extends AuthState {}

final class SignOutSuccess extends AuthState {}

final class SignOutFailure extends AuthState {
  final String errorMessage;

  const SignOutFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// ==================== [ Reset Password States ] ====================
final class ResetPasswordLoading extends AuthState {}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordFailure extends AuthState {
  final String errorMessage;

  const ResetPasswordFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

// ==================== [ Send Password Reset Email States ] ====================
final class SendPasswordResetEmailLoading extends AuthState {}

final class SendPasswordResetEmailSuccess extends AuthState {
  final String email;

  const SendPasswordResetEmailSuccess(this.email);

  @override
  List<Object?> get props => [email];
}

final class SendPasswordResetEmailFailure extends AuthState {
  final String errorMessage;

  const SendPasswordResetEmailFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// ==================== [ Fetch Email From Code States ] ====================
final class FetchEmailFromCodeLoading extends AuthState {}

final class FetchEmailFromCodeSuccess extends AuthState {
  final String email;

  const FetchEmailFromCodeSuccess(this.email);

  @override
  List<Object?> get props => [email];
}

final class FetchEmailFromCodeFailure extends AuthState {
  final String errorMessage;

  const FetchEmailFromCodeFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// ==================== [ Resend Timer States ] ====================
final class ResendTimerTick extends AuthState {
  final int secondsRemaining;

  const ResendTimerTick(this.secondsRemaining);

  @override
  List<Object> get props => [secondsRemaining];
}

final class ResendEmailLoading extends AuthState {}

final class ResendEmailSuccess extends AuthState {
  final DateTime? endTime;

  const ResendEmailSuccess({this.endTime});

  @override
  List<Object?> get props => [endTime];
}

final class ResendEmailFailure extends AuthState {
  final String errorMessage;

  const ResendEmailFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// ==================== [ OTP States (Reserved) ] ====================
final class PhoneOtpSent extends AuthState {
  final String verificationId;

  const PhoneOtpSent({required this.verificationId});

  @override
  List<Object?> get props => [verificationId];
}
