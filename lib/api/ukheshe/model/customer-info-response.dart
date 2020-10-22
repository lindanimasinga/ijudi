import 'package:ijudi/api/ukheshe/model/customer-status.dart';
import 'package:ijudi/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer-info-response.g.dart';

@JsonSerializable()
class CustomerInfoResponse extends Bank {
  final String email;
  final String username;
  final String idNumber;
  final bool merchant;

  CustomerInfoResponse(
      {int customerId,
      String accountId,
      String name,
      CustomerStatus status,
      this.email,
      this.username,
      this.idNumber,
      String phone,
      availableBalance = 0,
      currentBalance = 0,
      this.merchant = false})
      : super(
            accountId: accountId,
            type: "wallet",
            name: name,
            phone: phone,
            status: status,
            customerId: customerId,
            availableBalance: availableBalance,
            currentBalance: currentBalance);

  factory CustomerInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoResponseFromJson(json);
}
