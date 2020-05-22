
import 'package:json_annotation/json_annotation.dart';

part 'jwt-response.g.dart';

@JsonSerializable()
class JWTResponse {

  final String expires;
  final String headerName;
  final String headerValue;
  final double expiresEpochSecs;

  JWTResponse(this.expires, this.headerName, this.headerValue, this.expiresEpochSecs);

  factory JWTResponse.fromJson(Map<String, dynamic> json) => _$JWTResponseFromJson(json);
}