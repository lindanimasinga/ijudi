
import 'package:json_annotation/json_annotation.dart';

part 'init-topup-response.g.dart';

@JsonSerializable()
class InitTopUpResponse {
  double amount;
  String completionHtml;
  String completionUrl;
  String created;
  int customerId;
  String expires;
  int fee;
  String gatewayTransactionId;
  String info;
  String status;
  String token;
  int topUpId;
  String type;
  String uniqueId;
  bool useTokenisation;

  InitTopUpResponse(
      {this.amount,
      this.completionHtml,
      this.completionUrl,
      this.created,
      this.customerId,
      this.expires,
      this.fee,
      this.gatewayTransactionId,
      this.info,
      this.status,
      this.token,
      this.topUpId,
      this.type,
      this.uniqueId,
      this.useTokenisation});

 
 factory InitTopUpResponse.fromJson(Map<String, dynamic> json) => _$InitTopUpResponseFromJson(json);

 Map<String, dynamic> toJson() => _$InitTopUpResponseToJson(this); 

}