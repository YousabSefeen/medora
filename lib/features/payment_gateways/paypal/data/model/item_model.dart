import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
