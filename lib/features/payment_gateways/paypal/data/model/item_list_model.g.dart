// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemListModel _$ItemListModelFromJson(Map<String, dynamic> json) =>
    ItemListModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemListModelToJson(ItemListModel instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
