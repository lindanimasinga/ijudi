
import 'package:ijudi/model/selection-option.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'basket-item.g.dart';

@JsonSerializable(includeIfNull: false)
class BasketItem {
  
  String name;
  int quantity;
  double _price;

  double discountPerc;
  List<SelectionOption> options;

  BasketItem({this.name, this.quantity, double price, this.discountPerc}): _price = price;

  @override
  int get hashCode => name.hashCode;

  double get price => _price + (options != null && options.isNotEmpty ? options.map((value) => value.price).reduce((value, element) => value + element) : 0);
  set price(double price) {
    _price = price;
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is BasketItem &&
    runtimeType == other.runtimeType &&
    name == other.name && listEquals(other.options, options);

  factory BasketItem.fromJson(Map<String, dynamic> json) => _$BasketItemFromJson(json);

  Map<String, dynamic> toJson() => _$BasketItemToJson(this);   
}