import 'basket-item.dart';

class Stock {
  String name;
  int _quantity;
  double price;
  double discountPerc;

  Stock({name: String, quantity: int, price: double, discountPerc = 0.0}) {
    this.name = name;
    this._quantity = quantity;
    this.price = price;
    this.discountPerc = discountPerc;
  }

  get itemsAvailable {
    return _quantity;
  }

  BasketItem take(int quantity) {
    if (quantity > _quantity) {
      return null;
    }

    _quantity = _quantity - quantity;
    return BasketItem(
        name: name,
        quantity: quantity,
        price: price,
        discountPerc: discountPerc);
  }

  put(int quantity) {
    _quantity = _quantity + quantity;
  }
}
