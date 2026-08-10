import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/auth_provider_type.dart';
import 'package:medora/features/auth/domain/params/reset_password_and_sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart'
    show SignInParams;
import 'package:medora/features/auth/domain/params/sign_up_params.dart'
    show SignUpParams;
import 'package:medora/features/auth/domain/params/verify_otp_and_update_password_params.dart';
import 'package:medora/features/auth/domain/params/verify_phone_and_send_otp_params.dart';
import 'package:medora/features/auth/domain/use_cases/fetch_email_from_code_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/reset_password_and_sign_in_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/verify_otp_and_update_password_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/verify_phone_and_send_otp_use_case.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final VerifyPhoneAndSendOtpUseCase _verifyPhoneAndSendOtpUseCase;
  final VerifyOtpAndUpdatePasswordUseCase _verifyOtpAndUpdatePasswordUseCase;
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;
  final FetchEmailFromCodeUseCase _fetchEmailFromCodeUseCase;
  final ResetPasswordAndSignInUseCase _resetPasswordAndSignInUseCase;

  AuthCubit({
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
    required SignOutUseCase signOutUseCase,
    required VerifyPhoneAndSendOtpUseCase verifyPhoneAndSendOtpUseCase,
    required VerifyOtpAndUpdatePasswordUseCase
    verifyOtpAndUpdatePasswordUseCase,
    required SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase,
    required FetchEmailFromCodeUseCase fetchEmailFromCodeUseCase,
    required ResetPasswordAndSignInUseCase resetPasswordAndSignInUseCase,
  }) : _signUpUseCase = signUpUseCase,
       _signInUseCase = signInUseCase,
       _signOutUseCase = signOutUseCase,
       _verifyPhoneAndSendOtpUseCase = verifyPhoneAndSendOtpUseCase,
       _verifyOtpAndUpdatePasswordUseCase = verifyOtpAndUpdatePasswordUseCase,
       _sendPasswordResetEmailUseCase = sendPasswordResetEmailUseCase,
       _fetchEmailFromCodeUseCase = fetchEmailFromCodeUseCase,
       _resetPasswordAndSignInUseCase = resetPasswordAndSignInUseCase,
       super(AuthInitial());

  Future<void> signUp({required SignUpParams params}) async {
    final providerType = params.providerType;
    emit(AuthLoading(providerType));
    final result = await _signUpUseCase.call(params);

    result.fold(
      (failure) => emit(
        AuthFailure(
          providerType: providerType,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) => emit(AuthSuccess(providerType)),
    );
  }

  Future<void> signIn({required SignInParams params}) async {
    final providerType = params.providerType;
    emit(AuthLoading(providerType));
    final result = await _signInUseCase.call(params);

    result.fold(
      (failure) => emit(
        AuthFailure(
          providerType: providerType,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) => emit(AuthSuccess(providerType)),
    );
  }

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await _signOutUseCase(const NoParams());
    result.fold(
      (failure) => emit(SignOutFailure(failure.errorMessage)),
      (_) => emit(SignOutSuccess()),
    );
  }

  String? currentRecoveryEmail;
  String? currentOobCode;
  DateTime? _resendEndTime;

  void updateRecoveryEmail(String email) => currentRecoveryEmail = email;

  void updateOobCode(String oobCode) => currentOobCode = oobCode;

  Future<void> sendPasswordResetEmail({required String email}) async {
    updateRecoveryEmail(email);
    emit(SendPasswordResetEmailLoading());
    final result = await _sendPasswordResetEmailUseCase.call(email);

    result.fold(
      (failure) => emit(SendPasswordResetEmailFailure(failure.errorMessage)),
      (_) => emit(SendPasswordResetEmailSuccess(email)),
    );
  }

  Future<void> fetchEmailFromCode({required String oobCode}) async {
    emit(FetchEmailFromCodeLoading());
    updateOobCode(oobCode);
    final result = await _fetchEmailFromCodeUseCase.call(oobCode);

    result.fold(
      (failure) => emit(FetchEmailFromCodeFailure(failure.errorMessage)),
      (email) {
        updateRecoveryEmail(email);
        emit(FetchEmailFromCodeSuccess(email));
      },
    );
  }

  Future<void> resetPasswordAndSignIn({
    required String oobCode,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());

    final params = ResetPasswordParams(
      oobCode: oobCode,
      newPassword: newPassword,
      email: currentRecoveryEmail ?? '',
    );

    final result = await _resetPasswordAndSignInUseCase.call(params);

    result.fold(
      (failure) =>
          emit(ResetPasswordFailure(errorMessage: failure.errorMessage)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }

  Future<void> resendResetPassword(String email) async {
    emit(ResendEmailLoading());

    final result = await _sendPasswordResetEmailUseCase(email);

    result.fold((failure) => emit(ResendEmailFailure(failure.errorMessage)), (
      _,
    ) {
      _resendEndTime = DateTime.now().add(const Duration(seconds: 30));
      emit(ResendEmailSuccess(endTime: _resendEndTime));
    });
  }

  int getSecondsRemaining() {
    if (_resendEndTime == null) return 0;
    final diff = _resendEndTime!.difference(DateTime.now()).inSeconds;
    return diff > 0 ? diff : 0;
  }

  // ==================== [ OTP Functions ] ====================

  Future<void> verifyPhoneAndSendOtp({required String email}) async {
    final result = await _verifyPhoneAndSendOtpUseCase.call(
      VerifyPhoneAndSendOtpParams(
        email: email,
        onCodeSent: (String verificationId) {
          emit(PhoneOtpSent(verificationId: verificationId));
        },
        onVerificationFailed: (String errorMessage) {
          emit(
            AuthFailure(
              providerType: AuthProviderType.email,
              errorMessage: errorMessage,
            ),
          );
        },
      ),
    );

    result.fold((failure) {}, (_) {});
  }

  Future<void> verifyOtpAndUpdatePassword({
    required String email,
    required String verificationId,
    required String smsCode,
    required String newPassword,
  }) async {
    final result = await _verifyOtpAndUpdatePasswordUseCase.call(
      VerifyOtpAndUpdatePasswordParams(
        email: email,
        verificationId: verificationId,
        smsCode: smsCode,
        newPassword: newPassword,
      ),
    );

    result.fold(
      (failure) => ResendEmailFailure(failure.errorMessage),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
