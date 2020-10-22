import 'package:ijudi/model/selection-option.dart';
import 'package:json_annotation/json_annotation.dart';

import 'basket-item.dart';

part 'stock.g.dart';

@JsonSerializable(includeIfNull: false)
class Stock {
  String id;
  String name;
  String description;
  int quantity;
  double _price;

  double discountPerc;
  List<String> images;
  List<SelectionOption> mandatorySelection = [];
  List<SelectionOption> optionalSelection = [];

  Stock(
      {this.name,
      this.quantity = 0,
      double price = 0,
      this.discountPerc = 0.0}) {
    this.name = name;
    this.quantity = quantity;
    this.price = price;
    this.discountPerc = discountPerc;
  }

  double get price =>
      _price +
      (mandatorySelection != null && mandatorySelection.isNotEmpty
          ? mandatorySelection
              .map((value) =>
                  "none" == value.selected?.toLowerCase() ? 0 : value.price)
              .reduce((value, element) => value + element)
          : 0);

  get shouldSelectOptions =>
      mandatorySelection != null && mandatorySelection.isNotEmpty;

  set price(double price) {
    _price = price;
  }

  get itemsAvailable {
    return quantity;
  }

  bool get hasImages => images != null && images.length > 0;

  BasketItem take(int quantity) {
    if (quantity > this.quantity) {
      return null;
    }

    this.quantity = this.quantity - quantity;
    return BasketItem(
        name: name,
        quantity: quantity,
        price: price,
        discountPerc: discountPerc)
      ..options = mandatorySelection == null
          ? []
          : mandatorySelection
              .map((e) => SelectionOption()
                ..name = e.name
                ..price = e.price
                ..selected = e.selected)
              .toList();
  }

  put(int quantity) {
    this.quantity = this.quantity + quantity;
  }

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);
}
