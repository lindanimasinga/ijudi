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
    email: json['email'] as String,
    username: json['username'] as String,
    idNumber: json['idNumber'] as String,
    phone: json['phone'] as String,
    availableBalance: (json['availableBalance'] as num)?.toDouble(),
    currentBalance: (json['currentBalance'] as num)?.toDouble(),
    merchant: json['merchant'] as bool,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$CustomerInfoResponseToJson(
        CustomerInfoResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'customerId': instance.customerId,
      'accountId': instance.accountId,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'idNumber': instance.idNumber,
      'phone': instance.phone,
      'availableBalance': instance.availableBalance,
      'currentBalance': instance.currentBalance,
      'merchant': instance.merchant,
    };
