// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    name: json['name'] as String,
    status: json['status'] == null
        ? null
        : CustomerStatus.fromJson(json['status'] as Map<String, dynamic>),
    accountId: json['accountId'] as String,
    type: json['type'] as String,
    currentBalance: (json['currentBalance'] as num)?.toDouble(),
    availableBalance: (json['availableBalance'] as num)?.toDouble(),
    phone: json['phone'] as String,
    customerId: json['customerId'] as int,
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('accountId', instance.accountId);
  writeNotNull('customerId', instance.customerId);
  writeNotNull('type', instance.type);
  writeNotNull('currentBalance', instance.currentBalance);
  writeNotNull('availableBalance', instance.availableBalance);
  writeNotNull('status', instance.status);
  return val;
}
