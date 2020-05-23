import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StartShoppingViewModel extends BaseViewModel {
  
  final Shop _shop;
  Shop get shop => _shop;

  StartShoppingViewModel(this._shop);

  List<Stock> _stocks;

  Order order;

  @override
  void initialize() {
    order = Order();
    order.shop = _shop;
    ApiService.findUserById("")
      .asStream()
      .listen((user) {
        order.customer = user;
      });
    
    ApiService.findAllStockByShopId(shop.id)
    .asStream()
    .listen((resp) {
        stocks = resp;
      }, onDone: () {
      
      });  
  }

  void remove(BasketItem basketItem) {
    order.basket.removeOneItem(basketItem);
    stocks.firstWhere((elem) => elem.name == basketItem.name).put(1);
    notifyChanged();
  }

  void add(basketItem) {
    order.basket.addItem(basketItem);
    notifyChanged();
  }

  void verifyItemsAvailable() {
    progressMv.isBusy = true;
    var subscr = ApiService.verifyCanBuy(order.basket)
                  .asStream()
                  .listen(null);
    subscr.onData((data) {
      Navigator.pushNamed(context, DeliveryOptionsView.ROUTE_NAME,
          arguments: order);
    });
    subscr.onDone(() => progressMv.isBusy = false);
  }

  List<Stock> get stocks => _stocks;

  set stocks(List<Stock> stocks) {
    _stocks = stocks;
    notifyChanged();
  }
}
