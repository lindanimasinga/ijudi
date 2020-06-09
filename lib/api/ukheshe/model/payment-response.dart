
import 'package:json_annotation/json_annotation.dart';

part 'payment-response.g.dart';

@JsonSerializable()
class PaymentResponse {

  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String description;
  final String uniqueId;
  final String externalId;
  final String type;
  final String message;
  final DateTime date;

  PaymentResponse(this.fromAccountId, this.toAccountId, this.amount, this.description, this.uniqueId, this.externalId, this.type, this.message, this.date);

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);
}