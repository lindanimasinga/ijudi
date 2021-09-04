// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote-message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMessage _$RemoteMessageFromJson(Map<String, dynamic> json) {
  return RemoteMessage()
    ..messageType =
        _$enumDecodeNullable(_$MessageTypeEnumMap, json['messageType'])
    ..messageContent = json['messageContent'];
}

Map<String, dynamic> _$RemoteMessageToJson(RemoteMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('messageType', _$MessageTypeEnumMap[instance.messageType]);
  writeNotNull('messageContent', instance.messageContent);
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$MessageTypeEnumMap = {
  MessageType.NEW_ORDER: 'NEW_ORDER',
  MessageType.MARKETING: 'MARKETING',
  MessageType.PAYMENT: 'PAYMENT',
  MessageType.NEW_ORDER_UPDATE: 'NEW_ORDER_UPDATE',
};
