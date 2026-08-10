import 'package:medora/core/enum/auth_provider_type.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';

class ResetPasswordParams {
  final String oobCode;
  final String email;
  final String newPassword;

  const ResetPasswordParams({
    required this.oobCode,
    required this.email,
    required this.newPassword,
  });

  SignInParams toSignInParams() {
    return SignInParams(
      providerType: AuthProviderType.email,
      email: email,
      password: newPassword,
    );
  }
}
