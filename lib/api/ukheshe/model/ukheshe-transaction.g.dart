// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ukheshe-transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UkhesheTransaction _$UkhesheTransactionFromJson(Map<String, dynamic> json) {
  return UkhesheTransaction(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['amount'] as num)?.toDouble(),
    json['description'] as String,
    json['type'] as String,
    json['subType'] as String,
  );
}

Map<String, dynamic> _$UkhesheTransactionToJson(UkhesheTransaction instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
      'type': instance.type,
      'subType': instance.subType,
    };
