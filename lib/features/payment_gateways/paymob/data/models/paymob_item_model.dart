import 'package:json_annotation/json_annotation.dart';

part 'paymob_item_model.g.dart';

@JsonSerializable()
class PaymobItemModel {
  final String name;
  final int amount;
  final String description;
  final int quantity;

  PaymobItemModel({
    required this.name,
    required this.amount,
    required this.description,
    required this.quantity,
  });

  factory PaymobItemModel.fromJson(Map<String, dynamic> json) =>
      _$PaymobItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymobItemModelToJson(this);
}
