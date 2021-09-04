import 'package:json_annotation/json_annotation.dart';

part 'store-messenger.g.dart';

@JsonSerializable(includeIfNull: false)
class StoreMessenger {

  final String? id;
  final String? name;
  final double? standardDeliveryPrice;
  final double? standardDeliveryKm;
  final double? ratePerKm;

  StoreMessenger(this.id, this.name, this.standardDeliveryPrice, this.standardDeliveryKm, this.ratePerKm);

  factory StoreMessenger.fromJson(Map<String, dynamic> json) => _$StoreMessengerFromJson(json);

  Map<String, dynamic> toJson() => _$StoreMessengerToJson(this); 
}
