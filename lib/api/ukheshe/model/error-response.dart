import 'package:json_annotation/json_annotation.dart';

part 'error-response.g.dart';

@JsonSerializable()
class UkhesheErrorResponse {
  String code;
  String description;
  String severity;
  String type;

  UkhesheErrorResponse();

  factory UkhesheErrorResponse.fromJson(Map<String, dynamic> json) => _$UkhesheErrorResponseFromJson(json);
}