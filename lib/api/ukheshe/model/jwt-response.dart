
import 'package:json_annotation/json_annotation.dart';

part 'jwt-response.g.dart';

@JsonSerializable()
class JWTResponse {

  final DateTime expires;
  final headerName;
  final headerValue;
  final double expiresEpochSecs;

  JWTResponse(this.expires, this.headerName, this.headerValue, this.expiresEpochSecs);

  factory JWTResponse.fromJson(Map<String, dynamic> json) => _$JWTResponseFromJson(json);
}