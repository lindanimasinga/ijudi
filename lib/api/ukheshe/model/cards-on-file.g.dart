// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards-on-file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardsOnFile _$CardsOnFileFromJson(Map<String, dynamic> json) {
  return CardsOnFile(
    json['alias'] as String,
    json['tokenKey'] as String,
    json['last4Digits'] as String,
  );
}

Map<String, dynamic> _$CardsOnFileToJson(CardsOnFile instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'tokenKey': instance.tokenKey,
      'last4Digits': instance.last4Digits,
    };
