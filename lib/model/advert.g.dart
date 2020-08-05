// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advert _$AdvertFromJson(Map<String, dynamic> json) {
  return Advert()
    ..id = json['id'] as String
    ..imageUrl = json['imageUrl'] as String
    ..actionUrl = json['actionUrl'] as String
    ..shopId = json['shopId'] as String
    ..title = json['title'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$AdvertToJson(Advert instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'actionUrl': instance.actionUrl,
      'shopId': instance.shopId,
      'title': instance.title,
      'message': instance.message,
    };
