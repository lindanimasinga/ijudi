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

const _$MessageTypeEnumMap = {
  MessageType.NEW_ORDER: 'NEW_ORDER',
  MessageType.MARKETING: 'MARKETING',
  MessageType.PAYMENT: 'PAYMENT',
};
