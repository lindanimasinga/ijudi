// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop(
    id: json['id'] as String,
    name: json['name'] as String,
    registrationNumber: json['registrationNumber'] as String?,
    stockList: (json['stockList'] as List<dynamic>)
        .map((e) => Stock.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasVat: json['hasVat'] as bool?,
    scheduledDeliveryAllowed: json['scheduledDeliveryAllowed'] as bool,
    deliverNowAllowed: json['deliverNowAllowed'] as bool,
    tags: (json['tags'] as List<dynamic>).map((e) => e as String).toSet(),
    featured: json['featured'] as bool,
    ownerId: json['ownerId'] as String,
    businessHours: (json['businessHours'] as List<dynamic>)
        .map((e) => BusinessHours.fromJson(e as Map<String, dynamic>))
        .toList(),
    featuredExpiry: Utils.dateFromJson(json['featuredExpiry'] as String?),
    storeOffline: json['storeOffline'] as bool,
    availability: json['availability'] as String,
    markUpPrice: json['markUpPrice'] as bool,
    shortName: json['shortName'] as String?,
    storeType: json['storeType'] as String,
    description: json['description'] as String?,
    yearsInService: json['yearsInService'] as int?,
    address: json['address'] as String?,
    imageUrl: json['imageUrl'] as String?,
    likes: json['likes'] as int?,
    servicesCompleted: json['servicesCompleted'] as int?,
    badges: json['badges'] as int?,
    verificationCode: json['verificationCode'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
    role: _$enumDecodeNullable(_$ProfileRolesEnumMap, json['role']),
    bank: json['bank'] == null
        ? null
        : Bank.fromJson(json['bank'] as Map<String, dynamic>),
  )
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..longitude = (json['longitude'] as num?)?.toDouble()
    ..responseTimeMinutes = json['responseTimeMinutes'] as int?
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

  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
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
  val['storeType'] = instance.storeType;
  writeNotNull('registrationNumber', instance.registrationNumber);
  writeNotNull(
      'businessHours', Shop.businessHoursToJson(instance.businessHours));
  writeNotNull('stockList', Shop.listToJson(instance.stockList));
  val['tags'] = instance.tags.toList();
  writeNotNull('hasVat', instance.hasVat);
  val['scheduledDeliveryAllowed'] = instance.scheduledDeliveryAllowed;
  val['deliverNowAllowed'] = instance.deliverNowAllowed;
  val['ownerId'] = instance.ownerId;
  val['featured'] = instance.featured;
  val['markUpPrice'] = instance.markUpPrice;
  writeNotNull('featuredExpiry', Utils.dateToJson(instance.featuredExpiry));
  writeNotNull('storeMessenger', instance.storeMessenger);
  val['storeOffline'] = instance.storeOffline;
  val['availability'] = instance.availability;
  writeNotNull('shortName', instance.shortName);
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ProfileRolesEnumMap = {
  ProfileRoles.CUSTOMER: 'CUSTOMER',
  ProfileRoles.STORE_ADMIN: 'STORE_ADMIN',
  ProfileRoles.STORE: 'STORE',
  ProfileRoles.MESSENGER: 'MESSENGER',
};
