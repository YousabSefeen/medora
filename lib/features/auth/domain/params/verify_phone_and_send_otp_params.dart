import 'package:equatable/equatable.dart' show Equatable;

class VerifyPhoneAndSendOtpParams extends Equatable {
  final String email;
  final Function(String verificationId) onCodeSent;
  final Function(String errorMessage) onVerificationFailed;

  const VerifyPhoneAndSendOtpParams({
    required this.email,
    required this.onCodeSent,
    required this.onVerificationFailed,
  });

  @override
  List<Object?> get props => [email, onCodeSent, onVerificationFailed];
}
