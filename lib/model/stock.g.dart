// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) {
  return Stock(
    name: json['name'] as String?,
    quantity: json['quantity'] as int?,
    price: (json['price'] as num?)?.toDouble(),
    storePrice: (json['storePrice'] as num?)?.toDouble(),
    discountPerc: (json['discountPerc'] as num?)?.toDouble(),
    group: json['group'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  )
    ..id = json['id'] as String?
    ..description = json['description'] as String?
    ..images =
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..mandatorySelection = (json['mandatorySelection'] as List<dynamic>?)
        ?.map((e) => SelectionOption.fromJson(e as Map<String, dynamic>))
        .toList()
    ..optionalSelection = (json['optionalSelection'] as List<dynamic>?)
        ?.map((e) => SelectionOption.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$StockToJson(Stock instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('storePrice', instance.storePrice);
  writeNotNull('group', instance.group);
  writeNotNull('tags', instance.tags);
  writeNotNull('discountPerc', instance.discountPerc);
  writeNotNull('images', instance.images);
  writeNotNull('mandatorySelection', instance.mandatorySelection);
  writeNotNull('optionalSelection', instance.optionalSelection);
  val['price'] = instance.price;
  return val;
}
