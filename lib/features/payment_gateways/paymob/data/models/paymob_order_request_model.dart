import 'package:json_annotation/json_annotation.dart';

part 'paymob_order_request_model.g.dart';

@JsonSerializable()
class PaymobOrderRequestModel {
  final String? authToken;
  final String apiSource;
  final double totalPrice;
  final String currency;
  final ShippingData shippingData;
  final List<int> integrations;
  final List<OrderItem> items;
  final bool deliveryNeeded;

  PaymobOrderRequestModel({
    this.authToken,
    required this.apiSource,
    required this.totalPrice,
    required this.currency,
    required this.shippingData,
    required this.integrations,
    required this.items,
    required this.deliveryNeeded,
  });

  Map<String, dynamic> toJson() => _$PaymobOrderRequestModelToJson(this);
}

@JsonSerializable()
class ShippingData {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  ShippingData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$ShippingDataToJson(this);
}

@JsonSerializable()
class OrderItem {
  final String name;
  final int amountCents;
  final int quantity;
  final String description;

  OrderItem({
    required this.name,
    required this.amountCents,
    required this.quantity,
    required this.description,
  });

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
