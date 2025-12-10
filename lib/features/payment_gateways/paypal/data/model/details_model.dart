import 'package:json_annotation/json_annotation.dart';

part 'details_model.g.dart';

@JsonSerializable()
class DetailsModel {
  final String subtotal;
  final String shipping;
  final int shipping_discount;

  DetailsModel({
    required this.subtotal,
    required this.shipping,
    required this.shipping_discount,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsModelToJson(this);
}
