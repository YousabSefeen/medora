import 'package:equatable/equatable.dart' show Equatable;

class SignUpParams extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String role;

  const SignUpParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [name, phone, email, password, role];
}
