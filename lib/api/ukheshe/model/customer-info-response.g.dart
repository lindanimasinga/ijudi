// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer-info-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInfoResponse _$CustomerInfoResponseFromJson(Map<String, dynamic> json) {
  return CustomerInfoResponse(
    customerId: json['customerId'],
    accountId: json['accountId'],
    name: json['name'],
    email: json['email'] as String,
    username: json['username'] as String,
    idNumber: json['idNumber'] as String,
    phone: json['phone'],
    availableBalance: json['availableBalance'],
    currentBalance: json['currentBalance'],
    merchant: json['merchant'] as bool,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$CustomerInfoResponseToJson(
        CustomerInfoResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'accountId': instance.accountId,
      'customerId': instance.customerId,
      'type': instance.type,
      'currentBalance': instance.currentBalance,
      'availableBalance': instance.availableBalance,
      'email': instance.email,
      'username': instance.username,
      'idNumber': instance.idNumber,
      'merchant': instance.merchant,
    };
