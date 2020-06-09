// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop(
    id: json['id'] as String,
    name: json['name'] as String,
    registrationNumber: json['registrationNumber'] as String,
    stockList: (json['stockList'] as List)
        ?.map(
            (e) => e == null ? null : Stock.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    hasVat: json['hasVat'] as bool,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toSet(),
    description: json['description'] as String,
    yearsInService: json['yearsInService'] as int,
    address: json['address'] as String,
    imageUrl: json['imageUrl'] as String,
    likes: json['likes'] as int,
    servicesCompleted: json['servicesCompleted'] as int,
    badges: json['badges'] as int,
    verificationCode: json['verificationCode'] as String,
    mobileNumber: json['mobileNumber'] as String,
    role: json['role'] as String,
    bank: json['bank'] == null
        ? null
        : Bank.fromJson(json['bank'] as Map<String, dynamic>),
  )
    ..responseTimeMinutes = json['responseTimeMinutes'] as int
    ..businessHours = (json['businessHours'] as List)
        ?.map((e) => e == null
            ? null
            : BusinessHours.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..ownerId = json['ownerId'] as String;
}

Map<String, dynamic> _$ShopToJson(Shop instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('yearsInService', instance.yearsInService);
  writeNotNull('address', instance.address);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('likes', instance.likes);
  writeNotNull('servicesCompleted', instance.servicesCompleted);
  writeNotNull('badges', instance.badges);
  writeNotNull('mobileNumber', instance.mobileNumber);
  writeNotNull('role', instance.role);
  writeNotNull('responseTimeMinutes', instance.responseTimeMinutes);
  writeNotNull('verificationCode', instance.verificationCode);
  writeNotNull('bank', instance.bank);
  writeNotNull('registrationNumber', instance.registrationNumber);
  writeNotNull('businessHours', Shop.listToJson(instance.businessHours));
  writeNotNull('stockList', Shop.listToJson(instance.stockList));
  writeNotNull('tags', Shop.listToJson(instance.tags));
  writeNotNull('hasVat', instance.hasVat);
  writeNotNull('ownerId', instance.ownerId);
  return val;
}
