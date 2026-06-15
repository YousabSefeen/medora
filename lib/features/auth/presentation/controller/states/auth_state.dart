
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}

// ✨ حالات النجاح
final class SignInSuccess extends AuthState {}
final class SignUpSuccess extends AuthState {}

final class Authenticated extends AuthState {
  final String userId;
  const Authenticated(this.userId);

  @override
  List<Object?> get props => [userId]; // 👈 لضمان عدم التكرار إذا كان نفس الـ ID
}

final class Unauthenticated extends AuthState {}

// 🛡️ حالة الفشل المشتركة
final class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage]; // 👈 لضمان تحديث الـ UI إذا تغيرت رسالة الخطأ
}