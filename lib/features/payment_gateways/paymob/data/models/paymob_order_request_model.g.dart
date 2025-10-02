// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PaymobOrderRequestModelToJson(
        PaymobOrderRequestModel instance) =>
    <String, dynamic>{
      'auth_token': instance.authToken,
      'api_source': instance.apiSource,
      'amount_cents': instance.totalPrice,
      'currency': instance.currency,
      'shipping_data': instance.shippingData,
      'integrations': instance.integrations,
      'items': instance.items,
      'delivery_needed': instance.deliveryNeeded,
    };

Map<String, dynamic> _$ShippingDataToJson(ShippingData instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
    };

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'name': instance.name,
      'amount_cents': instance.amountCents,
      'quantity': instance.quantity,
      'description': instance.description,
    };
