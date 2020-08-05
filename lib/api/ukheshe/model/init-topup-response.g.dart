// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init-topup-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitTopUpResponse _$InitTopUpResponseFromJson(Map<String, dynamic> json) {
  return InitTopUpResponse(
    amount: (json['amount'] as num)?.toDouble(),
    completionHtml: json['completionHtml'] as String,
    completionUrl: json['completionUrl'] as String,
    created: json['created'] as String,
    customerId: json['customerId'] as int,
    expires: json['expires'] as String,
    fee: json['fee'] as int,
    gatewayTransactionId: json['gatewayTransactionId'] as String,
    info: json['info'] as String,
    status: json['status'] as String,
    token: json['token'] as String,
    topUpId: json['topUpId'] as int,
    type: json['type'] as String,
    uniqueId: json['uniqueId'] as String,
    useTokenisation: json['useTokenisation'] as bool,
  );
}

Map<String, dynamic> _$InitTopUpResponseToJson(InitTopUpResponse instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'completionHtml': instance.completionHtml,
      'completionUrl': instance.completionUrl,
      'created': instance.created,
      'customerId': instance.customerId,
      'expires': instance.expires,
      'fee': instance.fee,
      'gatewayTransactionId': instance.gatewayTransactionId,
      'info': instance.info,
      'status': instance.status,
      'token': instance.token,
      'topUpId': instance.topUpId,
      'type': instance.type,
      'uniqueId': instance.uniqueId,
      'useTokenisation': instance.useTokenisation,
    };
