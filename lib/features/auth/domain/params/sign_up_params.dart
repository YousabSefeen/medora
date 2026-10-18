import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/auth_provider_type.dart';

class SignUpParams extends Equatable {
  final AuthProviderType providerType;

  final String? email;
  final String? password;


  const SignUpParams({
    required this.providerType,

    this.email,
    this.password,

  });

  @override
  List<Object?> get props => [ email, password];
}
