import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/auth_provider_type.dart';

class AddUserParams extends Equatable {
  final String? name;
  final String? imageUrl;
  final String? phone;
  final String? email;
  final AuthProviderType authProviderType;

  const AddUserParams({
    this.name,
    this.imageUrl,
    this.phone,
    this.email,
    required this.authProviderType,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'imageUrl': imageUrl,
    'phone': phone,
    'email': email,
    'authProviderType': authProviderType,
  };

  @override
  List<Object?> get props => [name, imageUrl, phone, email, authProviderType];
}
