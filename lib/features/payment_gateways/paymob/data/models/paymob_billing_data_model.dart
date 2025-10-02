import 'package:json_annotation/json_annotation.dart';

part 'paymob_billing_data_model.g.dart';

@JsonSerializable()
class PaymobBillingDataModel {
  final String apartment;
  final String first_name;
  final String last_name;
  final String street;
  final String building;
  final String phone_number;
  final String city;
  final String country;
  final String email;
  final String state;

  final String floor;
  final String shipping_method;
  final String postal_code;

  PaymobBillingDataModel({
    required this.apartment,
    required this.first_name,
    required this.last_name,
    required this.street,
    required this.building,
    required this.phone_number,
    required this.city,
    required this.country,
    required this.email,
    required this.state,
    required this.floor,
    required this.shipping_method,
    required this.postal_code,
  });

  factory PaymobBillingDataModel.fromJson(Map<String, dynamic> json) =>
      _$PaymobBillingDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymobBillingDataModelToJson(this);
}
