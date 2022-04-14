// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Basket _$BasketFromJson(Map<String, dynamic> json) =>
    Basket()..items = Basket.listFromJson(json['items'] as List);

Map<String, dynamic> _$BasketToJson(Basket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('items', Basket.listToJson(instance.items));
  return val;
}
