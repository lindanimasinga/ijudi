// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store-messenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreMessenger _$StoreMessengerFromJson(Map<String, dynamic> json) =>
    StoreMessenger(
      json['id'] as String?,
      json['name'] as String?,
      (json['standardDeliveryPrice'] as num?)?.toDouble(),
      (json['standardDeliveryKm'] as num?)?.toDouble(),
      (json['ratePerKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StoreMessengerToJson(StoreMessenger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('standardDeliveryPrice', instance.standardDeliveryPrice);
  writeNotNull('standardDeliveryKm', instance.standardDeliveryKm);
  writeNotNull('ratePerKm', instance.ratePerKm);
  return val;
}
