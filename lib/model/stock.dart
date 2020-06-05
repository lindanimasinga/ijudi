import 'package:json_annotation/json_annotation.dart';

import 'basket-item.dart';

part 'stock.g.dart';

@JsonSerializable(includeIfNull: false)
class Stock {
  String name;
  int quantity;
  double price;
  double discountPerc;

  Stock({name: String, quantity: int, price: double, discountPerc = 0.0}) {
    this.name = name;
    this.quantity = quantity;
    this.price = price;
    this.discountPerc = discountPerc;
  }

  get itemsAvailable {
    return quantity;
  }

  BasketItem take(int quantity) {
    if (quantity > this.quantity) {
      return null;
    }

    this.quantity = this.quantity - quantity;
    return BasketItem(
        name: name,
        quantity: quantity,
        price: price,
        discountPerc: discountPerc);
  }

  put(int quantity) {
    this.quantity = this.quantity + quantity;
  }

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this); 
}
