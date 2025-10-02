import 'package:json_annotation/json_annotation.dart';

import 'item_model.dart';

part 'item_list_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemListModel {
  List<ItemModel> items;

  ItemListModel({required this.items});

  factory ItemListModel.fromJson(Map<String, dynamic> json) =>
      _$ItemListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListModelToJson(this);
}
