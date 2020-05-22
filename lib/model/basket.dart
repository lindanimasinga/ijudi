import 'dart:developer';

import 'package:ijudi/model/basket-item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'basket.g.dart';

@JsonSerializable(includeIfNull: false)
class Basket {
  
  @JsonKey(fromJson: listFromJson, toJson: listToJson)
  List<BasketItem> items = [];

  Basket();

  addItem(BasketItem basketItem) {
    BasketItem item = items.firstWhere(
        (element) => element.name == basketItem.name,
        orElse: () => null);
    if (item == null) {
      items.add(basketItem);
    } else {
      item.quantity = item.quantity + basketItem.quantity;
    }
  }

  removeOneItem(BasketItem basketItem) {
    BasketItem item = items.firstWhere(
        (element) => element.name == basketItem.name,
        orElse: () => null);

    if (item == null) return;
    if (item.quantity == 1) items.remove(item);

    item.quantity = item.quantity - 1;
  }

  double getBasketTotalAmount() {
    double totalAmount = 0;
    items.forEach((element) {
      totalAmount += element.price * element.quantity;
    });
    return totalAmount;
  }

  int getBasketTotalItems() {
    int totalAmount = 0;
    items.forEach((element) {
      totalAmount += element.quantity;
    });
    return totalAmount;
  }

  factory Basket.fromJson(Map<String, dynamic> json) => _$BasketFromJson(json);

  Map<String, dynamic> toJson() => _$BasketToJson(this);

  static List<BasketItem> listFromJson(List<dynamic> basketList) {
      log("converting from json");
      return basketList.map((f) => BasketItem.fromJson(f)).toList();
  }

  static List<Map<String,dynamic>> listToJson(List<BasketItem> list) {
    log("converting to json");
    var jsonString = list.map((f) => f.toJson())
      .toList();
    print(jsonString);
    return jsonString;  
  }
}
