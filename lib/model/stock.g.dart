// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) {
  return Stock(
    name: json['name'],
    quantity: json['quantity'],
    price: json['price'],
    discountPerc: json['discountPerc'],
  );
}

Map<String, dynamic> _$StockToJson(Stock instance) {
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
