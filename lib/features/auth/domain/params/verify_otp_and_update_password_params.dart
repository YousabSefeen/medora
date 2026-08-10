import 'package:equatable/equatable.dart' show Equatable;

class VerifyOtpAndUpdatePasswordParams extends Equatable {

  final String email;
  final String verificationId;
  final String smsCode;
  final String newPassword;
  const VerifyOtpAndUpdatePasswordParams({

    required this.email,
    required this.verificationId,
    required this.smsCode,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [
    email,
    verificationId,
    smsCode,
    newPassword,
  ];
}
