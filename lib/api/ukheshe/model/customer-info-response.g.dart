// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer-info-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInfoResponse _$CustomerInfoResponseFromJson(Map<String, dynamic> json) {
  return CustomerInfoResponse(
    customerId: json['customerId'] as int,
    accountId: json['accountId'] as String,
    name: json['name'] as String,
    status: json['status'] == null
        ? null
        : CustomerStatus.fromJson(json['status'] as Map<String, dynamic>),
    email: json['email'] as String,
    username: json['username'] as String,
    idNumber: json['idNumber'] as String,
    phone: json['phone'] as String,
    availableBalance: json['availableBalance'],
    currentBalance: json['currentBalance'],
    merchant: json['merchant'] as bool,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$CustomerInfoResponseToJson(
    CustomerInfoResponse instance) {
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
  val['email'] = instance.email;
  val['username'] = instance.username;
  val['idNumber'] = instance.idNumber;
  val['merchant'] = instance.merchant;
  return val;
}
