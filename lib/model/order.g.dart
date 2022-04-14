// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order()
  ..id = json['id'] as String?
  ..shippingData = json['shippingData'] == null
      ? null
      : Shipping.fromJson(json['shippingData'] as Map<String, dynamic>)
  ..paymentType = $enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType'])
  ..orderType = $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType'])
  ..hasVat = json['hasVat'] as bool?
  ..basket = json['basket'] == null
      ? null
      : Basket.fromJson(json['basket'] as Map<String, dynamic>)
  ..customerId = json['customerId'] as String?
  ..shopId = json['shopId'] as String?
  ..date = Order.dateFromJson(json['date'] as String)
  ..stage = $enumDecodeNullable(_$OrderStageEnumMap, json['stage'])
  ..serviceFee = (json['serviceFee'] as num?)?.toDouble()
  ..totalAmount = (json['totalAmount'] as num?)?.toDouble()
  ..description = json['description'] as String?;

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

const _$PaymentTypeEnumMap = {
  PaymentType.UKHESHE: 'UKHESHE',
  PaymentType.CASH: 'CASH',
  PaymentType.OZOW: 'OZOW',
  PaymentType.PAYFAST: 'PAYFAST',
  PaymentType.SPEED_POINT: 'SPEED_POINT',
  PaymentType.YOCO: 'YOCO',
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

Shipping _$ShippingFromJson(Map<String, dynamic> json) => Shipping()
  ..fromAddress = json['fromAddress'] as String?
  ..buildingType =
      $enumDecodeNullable(_$BuildingTypeEnumMap, json['buildingType'])
  ..unitNumber = json['unitNumber'] as String?
  ..buildingName = json['buildingName'] as String?
  ..toAddress = json['toAddress'] as String?
  ..additionalInstructions = json['additionalInstructions'] as String?
  ..type = $enumDecodeNullable(_$ShippingTypeEnumMap, json['type'])
  ..fee = (json['fee'] as num?)?.toDouble()
  ..distance = (json['distance'] as num?)?.toDouble()
  ..messenger = json['messenger'] == null
      ? null
      : UserProfile.fromJson(json['messenger'] as Map<String, dynamic>)
  ..pickUpTime = json['pickUpTime'] == null
      ? null
      : DateTime.parse(json['pickUpTime'] as String)
  ..messengerId = json['messengerId'] as String?;

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
  writeNotNull('distance', instance.distance);
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
