import 'package:json_annotation/json_annotation.dart';

import 'details_model.dart';

part 'amount_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AmountModel {
  final String total;
  final String currency;
  final DetailsModel details;

  AmountModel({
    required this.total,
    required this.currency,
    required this.details,
  });

  factory AmountModel.fromJson(Map<String, dynamic> json) =>
      _$AmountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AmountModelToJson(this);
}
