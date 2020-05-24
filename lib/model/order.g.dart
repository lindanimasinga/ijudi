// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order()
    ..id = json['id'] as String
    ..shippingData = json['shippingData'] == null
        ? null
        : Shipping.fromJson(json['shippingData'] as Map<String, dynamic>)
    ..paymentType =
        _$enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType'])
    ..basket = json['basket'] == null
        ? null
        : Basket.fromJson(json['basket'] as Map<String, dynamic>)
    ..customerId = json['customerId'] as String
    ..shopId = json['shopId'] as String
    ..date = Order.dateFromJson(json['date'] as String)
    ..stage = json['stage'] as int
    ..description = json['description'] as String;
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('shippingData', instance.shippingData);
  writeNotNull('paymentType', _$PaymentTypeEnumMap[instance.paymentType]);
  writeNotNull('basket', instance.basket);
  writeNotNull('customerId', instance.customerId);
  writeNotNull('shopId', instance.shopId);
  writeNotNull('date', instance.date?.toIso8601String());
  writeNotNull('stage', instance.stage);
  writeNotNull('description', instance.description);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PaymentTypeEnumMap = {
  PaymentType.UKHESHE: 'UKHESHE',
};

Shipping _$ShippingFromJson(Map<String, dynamic> json) {
  return Shipping()
    ..fromAddress = json['fromAddress'] as String
    ..toAddress = json['toAddress'] as String
    ..additionalInstructions = json['additionalInstructions'] as String
    ..type = _$enumDecodeNullable(_$ShippingTypeEnumMap, json['type'])
    ..fee = (json['fee'] as num)?.toDouble()
    ..messenger = json['messenger'] == null
        ? null
        : UserProfile.fromJson(json['messenger'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ShippingToJson(Shipping instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fromAddress', instance.fromAddress);
  writeNotNull('toAddress', instance.toAddress);
  writeNotNull('additionalInstructions', instance.additionalInstructions);
  writeNotNull('type', _$ShippingTypeEnumMap[instance.type]);
  writeNotNull('fee', instance.fee);
  writeNotNull('messenger', instance.messenger);
  return val;
}

const _$ShippingTypeEnumMap = {
  ShippingType.COLLECTION: 'COLLECTION',
  ShippingType.DELIVERY: 'DELIVERY',
};
