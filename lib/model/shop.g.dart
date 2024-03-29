// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['id'] as String,
      name: json['name'] as String,
      registrationNumber: json['registrationNumber'] as String?,
      stockList: (json['stockList'] as List<dynamic>)
          .map((e) => Stock.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasVat: json['hasVat'] as bool? ?? false,
      scheduledDeliveryAllowed:
          json['scheduledDeliveryAllowed'] as bool? ?? false,
      deliverNowAllowed: json['deliverNowAllowed'] as bool? ?? true,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet(),
      featured: json['featured'] as bool,
      ownerId: json['ownerId'] as String?,
      businessHours: (json['businessHours'] as List<dynamic>)
          .map((e) => BusinessHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredExpiry: Utils.dateFromJson(json['featuredExpiry'] as String?),
      storeOffline: json['storeOffline'] as bool,
      availability: json['availability'] as String?,
      markUpPrice: json['markUpPrice'] as bool? ?? true,
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
      role: $enumDecodeNullable(_$ProfileRolesEnumMap, json['role']),
      franchiseName: json['franchiseName'] as String?,
      bank: json['bank'] == null
          ? null
          : Bank.fromJson(json['bank'] as Map<String, dynamic>),
    )
      ..latitude = (json['latitude'] as num?)?.toDouble()
      ..longitude = (json['longitude'] as num?)?.toDouble()
      ..emailAddress = json['emailAddress'] as String?
      ..responseTimeMinutes = json['responseTimeMinutes'] as int?
      ..availabilityStatus = $enumDecodeNullable(
          _$ProfileAvailabilityStatusEnumMap, json['availabilityStatus'])
      ..storeMessenger = (json['storeMessenger'] as List<dynamic>?)
          ?.map((e) => StoreMessenger.fromJson(e as Map<String, dynamic>))
          .toList()
      ..franchises = (json['franchises'] as List<dynamic>?)
          ?.map((e) => Shop.fromJson(e as Map<String, dynamic>))
          .toList();

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
  writeNotNull('emailAddress', instance.emailAddress);
  writeNotNull('role', _$ProfileRolesEnumMap[instance.role]);
  writeNotNull('responseTimeMinutes', instance.responseTimeMinutes);
  writeNotNull('verificationCode', instance.verificationCode);
  writeNotNull('bank', instance.bank);
  writeNotNull('availabilityStatus',
      _$ProfileAvailabilityStatusEnumMap[instance.availabilityStatus]);
  val['storeType'] = instance.storeType;
  writeNotNull('registrationNumber', instance.registrationNumber);
  writeNotNull(
      'businessHours', Shop.businessHoursToJson(instance.businessHours));
  writeNotNull('stockList', Shop.listToJson(instance.stockList));
  writeNotNull('tags', instance.tags?.toList());
  writeNotNull('hasVat', instance.hasVat);
  val['scheduledDeliveryAllowed'] = instance.scheduledDeliveryAllowed;
  val['deliverNowAllowed'] = instance.deliverNowAllowed;
  writeNotNull('ownerId', instance.ownerId);
  val['featured'] = instance.featured;
  val['markUpPrice'] = instance.markUpPrice;
  writeNotNull('featuredExpiry', Utils.dateToJson(instance.featuredExpiry));
  writeNotNull('storeMessenger', instance.storeMessenger);
  val['storeOffline'] = instance.storeOffline;
  writeNotNull('availability', instance.availability);
  writeNotNull('shortName', instance.shortName);
  writeNotNull('franchiseName', instance.franchiseName);
  writeNotNull('franchises', instance.franchises);
  return val;
}

const _$ProfileRolesEnumMap = {
  ProfileRoles.CUSTOMER: 'CUSTOMER',
  ProfileRoles.STORE_ADMIN: 'STORE_ADMIN',
  ProfileRoles.STORE: 'STORE',
  ProfileRoles.MESSENGER: 'MESSENGER',
  ProfileRoles.ADMIN: 'ADMIN',
};

const _$ProfileAvailabilityStatusEnumMap = {
  ProfileAvailabilityStatus.ONLINE: 'ONLINE',
  ProfileAvailabilityStatus.OFFLINE: 'OFFLINE',
  ProfileAvailabilityStatus.AWAY: 'AWAY',
};
