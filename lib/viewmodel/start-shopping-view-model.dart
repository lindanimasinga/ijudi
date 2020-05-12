import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/busket-item.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/services/busket-service.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StartShoppingViewModel extends BaseViewModel {
  final Shop _shop;
  Shop get shop => _shop;

  StartShoppingViewModel(this._shop);

  List<Stock> _stock;

  List<Stock> get stock => _stock;
  set stock(List<Stock> stock) {
    _stock = stock;
  }

  Busket _busket;

  Busket get busket => _busket;
  set busket(Busket busket) {
    _busket = busket;
  }

  @override
  void initialize() {
    stock = ApiService.findAllStockByShopId(shop.id);
    busket = BusketService().createNew(currentUser, shop);
  }

  void remove(BusketItem busketItem) {
    busket.removeOneItem(busketItem);
    stock.firstWhere((elem) => elem.name == busketItem.name).put(1);
    notifyChanged();
  }

  void add(busketItem) {
    busket.addItem(busketItem);
    notifyChanged();
  }

  void verifyItemsAvailable() {
    progressMv.isBusy = true;
    var subscr = ApiService.verifyCanBuy(busket).listen(null);
    subscr.onData((data) {
      Navigator.pushNamed(context, DeliveryOptionsView.ROUTE_NAME, arguments: busket);
    });
    subscr.onDone(() => progressMv.isBusy = false);
  }
}
