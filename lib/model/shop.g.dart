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
    collectAllowed: json['collectAllowed'] as bool,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toSet(),
    featured: json['featured'] as bool,
    featuredExpiry: Utils.dateFromJson(json['featuredExpiry'] as String),
    storeOffline: json['storeOffline'] as bool,
    availability: json['availability'] as String,
    description: json['description'] as String,
    yearsInService: json['yearsInService'] as int,
    address: json['address'] as String,
    imageUrl: json['imageUrl'] as String,
    likes: json['likes'] as int,
    servicesCompleted: json['servicesCompleted'] as int,
    badges: json['badges'] as int,
    verificationCode: json['verificationCode'] as String,
    mobileNumber: json['mobileNumber'] as String,
    role: _$enumDecodeNullable(_$ProfileRolesEnumMap, json['role']),
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
    ..ownerId = json['ownerId'] as String
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..storeMessenger = json['storeMessenger'] == null
        ? null
        : StoreMessenger.fromJson(
            json['storeMessenger'] as Map<String, dynamic>);
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
  writeNotNull('role', _$ProfileRolesEnumMap[instance.role]);
  writeNotNull('responseTimeMinutes', instance.responseTimeMinutes);
  writeNotNull('verificationCode', instance.verificationCode);
  writeNotNull('bank', instance.bank);
  writeNotNull('registrationNumber', instance.registrationNumber);
  writeNotNull(
      'businessHours', Shop.businessHoursToJson(instance.businessHours));
  writeNotNull('stockList', Shop.listToJson(instance.stockList));
  writeNotNull('tags', instance.tags?.toList());
  writeNotNull('hasVat', instance.hasVat);
  writeNotNull('collectAllowed', instance.collectAllowed);
  writeNotNull('ownerId', instance.ownerId);
  writeNotNull('featured', instance.featured);
  writeNotNull('featuredExpiry', Utils.dateToJson(instance.featuredExpiry));
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('storeMessenger', instance.storeMessenger);
  writeNotNull('storeOffline', instance.storeOffline);
  writeNotNull('availability', instance.availability);
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

const _$ProfileRolesEnumMap = {
  ProfileRoles.CUSTOMER: 'CUSTOMER',
  ProfileRoles.STORE_ADMIN: 'STORE_ADMIN',
  ProfileRoles.STORE: 'STORE',
  ProfileRoles.MESSENGER: 'MESSENGER',
};
