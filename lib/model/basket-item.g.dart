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
  );
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
  writeNotNull('price', instance.price);
  writeNotNull('discountPerc', instance.discountPerc);
  return val;
}
