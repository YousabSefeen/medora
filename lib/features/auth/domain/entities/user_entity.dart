import 'package:equatable/equatable.dart' show Equatable;

class UserEntity extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String role;
  final String createdAt;

  const UserEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [name, phone, email, role, createdAt];
}
