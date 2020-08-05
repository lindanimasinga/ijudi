// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UkhesheErrorResponse _$UkhesheErrorResponseFromJson(Map<String, dynamic> json) {
  return UkhesheErrorResponse()
    ..code = json['code'] as String
    ..description = json['description'] as String
    ..severity = json['severity'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$UkhesheErrorResponseToJson(
        UkhesheErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'severity': instance.severity,
      'type': instance.type,
    };
