// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote-message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteMessage _$RemoteMessageFromJson(Map<String, dynamic> json) =>
    RemoteMessage()
      ..messageType =
          $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType'])
      ..messageContent = json['messageContent'];

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

const _$MessageTypeEnumMap = {
  MessageType.NEW_ORDER: 'NEW_ORDER',
  MessageType.MARKETING: 'MARKETING',
  MessageType.PAYMENT: 'PAYMENT',
  MessageType.NEW_ORDER_UPDATE: 'NEW_ORDER_UPDATE',
};
