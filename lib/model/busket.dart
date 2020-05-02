import 'package:ijudi/model/busket-item.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';

class Busket {

  final List<BusketItem> items = [];
  final UserProfile customer;
  final Shop shop;

  Busket(this.customer, this.shop);

  addItem(BusketItem busketItem) {
    BusketItem item = items.firstWhere(
        (element) => element.name == busketItem.name,
        orElse: () => null);
    if (item == null) {
      items.add(busketItem);
    } else {
      item.quantity = item.quantity + busketItem.quantity;
    }
  }

  removeOneItem(BusketItem busketItem) {
    BusketItem item = items.firstWhere(
        (element) => element.name == busketItem.name,
        orElse: () => null);
    
    if (item == null) return;
    if (item.quantity == 1) items.remove(item);

    item.quantity = item.quantity - 1;
  }

  double getBusketTotalAmount() {
    double totalAmount = 0;
    items.forEach((element) { 
      totalAmount += element.price * element.quantity;
    });
    return totalAmount;
  }

    int getBusketTotalItems() {
    int totalAmount = 0;
    items.forEach((element) { 
      totalAmount += element.quantity;
    });
    return totalAmount;
  }
}
