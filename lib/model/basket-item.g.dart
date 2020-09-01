// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket-item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketItem _$BasketItemFromJson(Map<String, dynamic> json) {
  return BasketItem(
    name: json['name'] as String,
    quantity: json['quantity'] as int,
    price: (json['price'] as num)?.toDouble(),
    discountPerc: (json['discountPerc'] as num)?.toDouble(),
  )..options = (json['options'] as List)
      ?.map((e) => e == null
          ? null
          : SelectionOption.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$BasketItemToJson(BasketItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('discountPerc', instance.discountPerc);
  writeNotNull('options', instance.options);
  writeNotNull('price', instance.price);
  return val;
}
