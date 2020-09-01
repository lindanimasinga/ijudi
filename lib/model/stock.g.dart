// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) {
  return Stock(
    name: json['name'] as String,
    quantity: json['quantity'] as int,
    price: (json['price'] as num)?.toDouble(),
    discountPerc: (json['discountPerc'] as num)?.toDouble(),
  )
    ..description = json['description'] as String
    ..images = (json['images'] as List)?.map((e) => e as String)?.toList()
    ..mandatorySelection = (json['mandatorySelection'] as List)
        ?.map((e) => e == null
            ? null
            : SelectionOption.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..optionalSelection = (json['optionalSelection'] as List)
        ?.map((e) => e == null
            ? null
            : SelectionOption.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$StockToJson(Stock instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('discountPerc', instance.discountPerc);
  writeNotNull('images', instance.images);
  writeNotNull('mandatorySelection', instance.mandatorySelection);
  writeNotNull('optionalSelection', instance.optionalSelection);
  writeNotNull('price', instance.price);
  return val;
}
