import 'dart:async';
import 'dart:developer';

import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class QuickPayViewModel extends BaseViewModel {
  final ApiService? apiService;
  final Shop? shop;
  UserProfile? customer;

  double _payAmount = 0;

  String _itemName = "";
  Order order = Order();
  int quantity = 1;
  bool? paymentSuccessful;

  QuickPayViewModel({this.apiService, this.shop});

  @override
  initialize() {}

  String get baseUrl => "";

  String get itemName => _itemName;
  set itemName(String itemName) {
    _itemName = itemName;
    notifyChanged();
  }

  double get payAmount => _payAmount;
  set payAmount(double payAmount) {
    _payAmount = payAmount;
  }

  pay() {}

  bool get isBalanceLow {
    return order.customer!.bank!.availableBalance! < order.totalAmount!;
  }

  StreamSubscription startOrder() {
    progressMv!.isBusy = true;
    order = new Order();
    order.customer = customer;
    order.shop = shop;
    order.orderType = OrderType.INSTORE;
    order.basket = Basket();
    order.description = "Payment from ${order.customer!.mobileNumber}";
    order.basket!.clear();
    var basketItem = BasketItem(
        name: itemName,
        quantity: quantity,
        price: payAmount,
        storePrice: payAmount);
    order.basket!.addItem(basketItem);
    var subscr = apiService!.startOrder(order).asStream().map((newOrder) {
      var oldOrder = order;
      order = newOrder;
      order.customer = oldOrder.customer;
      order.shop = oldOrder.shop;
      order.description =
          "Payment from ${order.customer!.mobileNumber}: order ${order.id}";
      log("reference is ${order.description}");
    }).listen(null);

    subscr.onError((error) {
      showError(error: error);
      clearOrder();
      hasError = true;
    });

    subscr.onDone(() => progressMv!.isBusy = false);
    return subscr;
  }

  clearOrder() {
    order.basket!.clear();
  }

  bool itemsSelected() {
    var items = itemName.split(", ").toSet();
    return shop!.tags!.intersection(items).length > 0;
  }
}
