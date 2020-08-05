// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) {
  return PaymentResponse(
    json['fromAccountId'] as String,
    json['toAccountId'] as String,
    (json['amount'] as num)?.toDouble(),
    json['description'] as String,
    json['uniqueId'] as String,
    json['externalId'] as String,
    json['type'] as String,
    json['message'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'fromAccountId': instance.fromAccountId,
      'toAccountId': instance.toAccountId,
      'amount': instance.amount,
      'description': instance.description,
      'uniqueId': instance.uniqueId,
      'externalId': instance.externalId,
      'type': instance.type,
      'message': instance.message,
      'date': instance.date?.toIso8601String(),
    };
