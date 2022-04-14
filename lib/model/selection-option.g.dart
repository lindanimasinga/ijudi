// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection-option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectionOption _$SelectionOptionFromJson(Map<String, dynamic> json) =>
    SelectionOption()
      ..name = json['name'] as String?
      ..price = (json['price'] as num?)?.toDouble()
      ..values =
          (json['values'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..selected = json['selected'] as String?;

Map<String, dynamic> _$SelectionOptionToJson(SelectionOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'values': instance.values,
      'selected': instance.selected,
    };
