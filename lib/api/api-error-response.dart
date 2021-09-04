import 'package:json_annotation/json_annotation.dart';

part 'api-error-response.g.dart';

@JsonSerializable()
class ApiErrorResponse {

    DateTime? timestamp;
    dynamic message;
    String? path;

    ApiErrorResponse();

    factory ApiErrorResponse.fromJson(Map<String, dynamic> json) => _$ApiErrorResponseFromJson(json);
}