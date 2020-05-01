class BusketItem {
  
  String name;
  int quantity;
  double price;
  double discountPerc;

  BusketItem({this.name, this.quantity, this.price, this.discountPerc});

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is BusketItem &&
    runtimeType == other.runtimeType &&
    name == other.name;
}