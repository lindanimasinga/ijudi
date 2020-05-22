// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt-response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTResponse _$JWTResponseFromJson(Map<String, dynamic> json) {
  return JWTResponse(
    json['expires'] as String,
    json['headerName'] as String,
    json['headerValue'] as String,
    (json['expiresEpochSecs'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$JWTResponseToJson(JWTResponse instance) =>
    <String, dynamic>{
      'expires': instance.expires,
      'headerName': instance.headerName,
      'headerValue': instance.headerValue,
      'expiresEpochSecs': instance.expiresEpochSecs,
    };
