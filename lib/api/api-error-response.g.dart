// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api-error-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorResponse _$ApiErrorResponseFromJson(Map<String, dynamic> json) {
  return ApiErrorResponse()
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String)
    ..message = json['message']
    ..path = json['path'] as String?;
}

Map<String, dynamic> _$ApiErrorResponseToJson(ApiErrorResponse instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'message': instance.message,
      'path': instance.path,
    };
