// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    id: json['id'] as String,
    name: json['name'] as String,
    idNumber: json['idNumber'] as String,
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
  )..responseTimeMinutes = json['responseTimeMinutes'] as int;
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
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
  writeNotNull('idNumber', instance.idNumber);
  return val;
}
