
import 'package:json_annotation/json_annotation.dart';

part 'basket-item.g.dart';

@JsonSerializable(includeIfNull: false)
class BasketItem {
  
  String name;
  int quantity;
  double price;
  double discountPerc;

  BasketItem({this.name, this.quantity, this.price, this.discountPerc});

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is BasketItem &&
    runtimeType == other.runtimeType &&
    name == other.name;

  factory BasketItem.fromJson(Map<String, dynamic> json) => _$BasketItemFromJson(json);

  Map<String, dynamic> toJson() => _$BasketItemToJson(this);   
}