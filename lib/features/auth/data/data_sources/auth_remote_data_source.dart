import 'package:medora/features/auth/domain/params/reset_password_and_sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp({required SignUpParams params});

  Future<void> signIn({required SignInParams params});

  Future<void> sendPasswordResetEmail({required String email});

  Future<String> fetchEmailFromCode({required String oobCode});

  Future<void> confirmPasswordReset({
    required ResetPasswordParams params,
  });

  Future<void> signOut();

  //  Step 1 in Forget Password: Get the phone from the Firestore and send the OTP
  Future<void> verifyPhoneAndSendOtp({
    required String email,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onVerificationFailed,
  });

  //  Step 2 in Forget Password: Check the OTP code and update the encrypted password immediately
  Future<void> verifyOtpAndUpdatePassword({
    required String email,
    required String verificationId,
    required String smsCode,
    required String newPassword,
  });
}
