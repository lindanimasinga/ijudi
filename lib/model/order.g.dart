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
    ..orderType = _$enumDecodeNullable(_$OrderTypeEnumMap, json['orderType'])
    ..hasVat = json['hasVat'] as bool
    ..basket = json['basket'] == null
        ? null
        : Basket.fromJson(json['basket'] as Map<String, dynamic>)
    ..customerId = json['customerId'] as String
    ..shopId = json['shopId'] as String
    ..date = Order.dateFromJson(json['date'] as String)
    ..stage = _$enumDecodeNullable(_$OrderStageEnumMap, json['stage'])
    ..serviceFee = (json['serviceFee'] as num)?.toDouble()
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
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
  writeNotNull('orderType', _$OrderTypeEnumMap[instance.orderType]);
  writeNotNull('hasVat', instance.hasVat);
  writeNotNull('basket', instance.basket);
  writeNotNull('customerId', instance.customerId);
  writeNotNull('shopId', instance.shopId);
  writeNotNull('date', instance.date?.toIso8601String());
  writeNotNull('stage', _$OrderStageEnumMap[instance.stage]);
  writeNotNull('serviceFee', instance.serviceFee);
  writeNotNull('totalAmount', instance.totalAmount);
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
  PaymentType.CASH: 'CASH',
  PaymentType.OZOW: 'OZOW',
  PaymentType.PAYFAST: 'PAYFAST',
};

const _$OrderTypeEnumMap = {
  OrderType.ONLINE: 'ONLINE',
  OrderType.INSTORE: 'INSTORE',
};

const _$OrderStageEnumMap = {
  OrderStage.STAGE_0_CUSTOMER_NOT_PAID: 'STAGE_0_CUSTOMER_NOT_PAID',
  OrderStage.STAGE_1_WAITING_STORE_CONFIRM: 'STAGE_1_WAITING_STORE_CONFIRM',
  OrderStage.STAGE_2_STORE_PROCESSING: 'STAGE_2_STORE_PROCESSING',
  OrderStage.STAGE_3_READY_FOR_COLLECTION: 'STAGE_3_READY_FOR_COLLECTION',
  OrderStage.STAGE_4_ON_THE_ROAD: 'STAGE_4_ON_THE_ROAD',
  OrderStage.STAGE_5_ARRIVED: 'STAGE_5_ARRIVED',
  OrderStage.STAGE_6_WITH_CUSTOMER: 'STAGE_6_WITH_CUSTOMER',
  OrderStage.STAGE_7_ALL_PAID: 'STAGE_7_ALL_PAID',
};

Shipping _$ShippingFromJson(Map<String, dynamic> json) {
  return Shipping()
    ..fromAddress = json['fromAddress'] as String
    ..buildingType =
        _$enumDecodeNullable(_$BuildingTypeEnumMap, json['buildingType'])
    ..unitNumber = json['unitNumber'] as String
    ..buildingName = json['buildingName'] as String
    ..toAddress = json['toAddress'] as String
    ..additionalInstructions = json['additionalInstructions'] as String
    ..type = _$enumDecodeNullable(_$ShippingTypeEnumMap, json['type'])
    ..fee = (json['fee'] as num)?.toDouble()
    ..messenger = json['messenger'] == null
        ? null
        : UserProfile.fromJson(json['messenger'] as Map<String, dynamic>)
    ..pickUpTime = json['pickUpTime'] == null
        ? null
        : DateTime.parse(json['pickUpTime'] as String)
    ..messengerId = json['messengerId'];
}

Map<String, dynamic> _$ShippingToJson(Shipping instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fromAddress', instance.fromAddress);
  writeNotNull('buildingType', _$BuildingTypeEnumMap[instance.buildingType]);
  writeNotNull('unitNumber', instance.unitNumber);
  writeNotNull('buildingName', instance.buildingName);
  writeNotNull('toAddress', instance.toAddress);
  writeNotNull('additionalInstructions', instance.additionalInstructions);
  writeNotNull('type', _$ShippingTypeEnumMap[instance.type]);
  writeNotNull('fee', instance.fee);
  writeNotNull('messenger', instance.messenger);
  writeNotNull('pickUpTime', instance.pickUpTime?.toIso8601String());
  writeNotNull('messengerId', instance.messengerId);
  return val;
}

const _$BuildingTypeEnumMap = {
  BuildingType.HOUSE: 'HOUSE',
  BuildingType.OFFICE: 'OFFICE',
  BuildingType.APARTMENT: 'APARTMENT',
};

const _$ShippingTypeEnumMap = {
  ShippingType.SCHEDULED_DELIVERY: 'SCHEDULED_DELIVERY',
  ShippingType.DELIVERY: 'DELIVERY',
};
