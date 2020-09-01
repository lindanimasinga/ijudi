// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection-option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectionOption _$SelectionOptionFromJson(Map<String, dynamic> json) {
  return SelectionOption()
    ..name = json['name'] as String
    ..price = (json['price'] as num)?.toDouble()
    ..selected = json['selected'] as String
    ..values = (json['values'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$SelectionOptionToJson(SelectionOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'selected': instance.selected,
      'values': instance.values,
    };
