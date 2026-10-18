// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  authProviderType: json['authProviderType'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'authProviderType': instance.authProviderType,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'phone': instance.phone,
  'email': instance.email,
};
