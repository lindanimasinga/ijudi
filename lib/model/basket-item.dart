import 'package:ijudi/model/selection-option.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'basket-item.g.dart';

@JsonSerializable(includeIfNull: false)
class BasketItem {
  String? name;
  int? quantity;
  double? _price;
  double? _storePrice;
  double? discountPerc;
  List<SelectionOption>? options;

  BasketItem(
      {this.name,
      this.quantity,
      double? price,
      double? storePrice,
      this.discountPerc}) {
    this._price = price;
    this._storePrice = storePrice;
  }

  @override
  int get hashCode => name.hashCode;

  double get price =>
      _price! +
      (null == null
          ? 0
          : options
              ?.map((e) => e.selected!.toLowerCase() == "none" ? 0 : e.price)
              ?.reduce((previousValue, current) => previousValue! + current!)!)!;

  double get storePrice =>
      _storePrice! +
      (null == null
          ? 0
          : options!
              .map((e) => e.selected!.toLowerCase() == "none" ? 0 : e.price)
              .reduce((previousValue, current) => previousValue! + current!)!);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          listEquals(other.options, options);

  factory BasketItem.fromJson(Map<String, dynamic> json) =>
      _$BasketItemFromJson(json);

  Map<String, dynamic> toJson() => _$BasketItemToJson(this);
}
