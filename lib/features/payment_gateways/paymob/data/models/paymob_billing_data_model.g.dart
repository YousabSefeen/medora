// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_billing_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobBillingDataModel _$PaymobBillingDataModelFromJson(
        Map<String, dynamic> json) =>
    PaymobBillingDataModel(
      apartment: json['apartment'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      street: json['street'] as String,
      building: json['building'] as String,
      phone_number: json['phone_number'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      email: json['email'] as String,
      state: json['state'] as String,
      floor: json['floor'] as String,
      shipping_method: json['shipping_method'] as String,
      postal_code: json['postal_code'] as String,
    );

Map<String, dynamic> _$PaymobBillingDataModelToJson(
        PaymobBillingDataModel instance) =>
    <String, dynamic>{
      'apartment': instance.apartment,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'street': instance.street,
      'building': instance.building,
      'phone_number': instance.phone_number,
      'city': instance.city,
      'country': instance.country,
      'email': instance.email,
      'state': instance.state,
      'floor': instance.floor,
      'shipping_method': instance.shipping_method,
      'postal_code': instance.postal_code,
    };
