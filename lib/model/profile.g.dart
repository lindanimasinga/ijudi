// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      name: json['name'] as String?,
      idNumber: json['idNumber'] as String?,
      accountId: json['accountId'] as String? ?? "- - -",
      type: $enumDecodeNullable(_$BankAccTypeEnumMap, json['type']),
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0,
      availableBalance: (json['availableBalance'] as num?)?.toDouble() ?? 0,
      phone: json['phone'] as String? ?? "- - -",
      customerId: json['customerId'] as int?,
    )..branchCode = json['branchCode'] as String?;

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
  writeNotNull('type', _$BankAccTypeEnumMap[instance.type]);
  writeNotNull('branchCode', instance.branchCode);
  writeNotNull('customerId', instance.customerId);
  writeNotNull('currentBalance', instance.currentBalance);
  writeNotNull('availableBalance', instance.availableBalance);
  writeNotNull('idNumber', instance.idNumber);
  return val;
}

const _$BankAccTypeEnumMap = {
  BankAccType.CHEQUE: 'CHEQUE',
  BankAccType.EWALLET: 'EWALLET',
  BankAccType.SAVINGS: 'SAVINGS',
  BankAccType.TRANSMISSION: 'TRANSMISSION',
};
