import 'package:equatable/equatable.dart' show Equatable;

class UserEntity extends Equatable {
  final String? id;
  final String authProviderType;
  final String name;
  final String imageUrl;
  final String phone;
  final String email;

  const UserEntity({
    this.id,
    required this.authProviderType,
    required this.name,
    required this.imageUrl,

    required this.phone,
    required this.email,
  });

  @override
  List<Object?> get props => [
    id,
    authProviderType,
    name,
    imageUrl,
    phone,
    email,
  ];
}
