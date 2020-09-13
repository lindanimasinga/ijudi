import 'package:json_annotation/json_annotation.dart';

part 'withdrawal.g.dart';

@JsonSerializable(includeIfNull: false)
class Withdrawal {
  double amount;
  DateTime created;
  int customerId;
  String description;
  DateTime expires;
  double fee;
  String partner;
  WithdrawalStatus status;
  String token;
  String type;
  String uniqueId;
  int withdrawalId;

  Withdrawal();

  factory Withdrawal.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalFromJson(json);
}

enum WithdrawalStatus { CANCELLED, PENDING, SUCCESSFUL, TIMEOUT }
