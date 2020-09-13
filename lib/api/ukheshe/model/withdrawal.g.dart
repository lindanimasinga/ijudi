// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Withdrawal _$WithdrawalFromJson(Map<String, dynamic> json) {
  return Withdrawal()
    ..amount = (json['amount'] as num)?.toDouble()
    ..created = json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String)
    ..customerId = json['customerId'] as int
    ..description = json['description'] as String
    ..expires = json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String)
    ..fee = (json['fee'] as num)?.toDouble()
    ..partner = json['partner'] as String
    ..status = _$enumDecodeNullable(_$WithdrawalStatusEnumMap, json['status'])
    ..token = json['token'] as String
    ..type = json['type'] as String
    ..uniqueId = json['uniqueId'] as String
    ..withdrawalId = json['withdrawalId'] as int;
}

Map<String, dynamic> _$WithdrawalToJson(Withdrawal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('amount', instance.amount);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('customerId', instance.customerId);
  writeNotNull('description', instance.description);
  writeNotNull('expires', instance.expires?.toIso8601String());
  writeNotNull('fee', instance.fee);
  writeNotNull('partner', instance.partner);
  writeNotNull('status', _$WithdrawalStatusEnumMap[instance.status]);
  writeNotNull('token', instance.token);
  writeNotNull('type', instance.type);
  writeNotNull('uniqueId', instance.uniqueId);
  writeNotNull('withdrawalId', instance.withdrawalId);
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

const _$WithdrawalStatusEnumMap = {
  WithdrawalStatus.CANCELLED: 'CANCELLED',
  WithdrawalStatus.PENDING: 'PENDING',
  WithdrawalStatus.SUCCESSFUL: 'SUCCESSFUL',
  WithdrawalStatus.TIMEOUT: 'TIMEOUT',
};
