import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StartShoppingViewModel extends BaseViewModel with MessageDialogs {
  final Shop shop;
  final ApiService apiService;
  final StorageManager storageManager;

  StartShoppingViewModel(
      {this.shop, @required this.apiService, @required this.storageManager});

  List<Stock> _stocks;
  Order order;
  String _search = "";

  @override
  void initialize() {
    BaseViewModel.analytics
        .logViewItemList(itemCategory: shop.name)
        .then((value) => null);

    order = Order();
    order.shop = shop;
    order.description = "order from ${shop.name}";
    stocks = shop.stockList;
    var userId = apiService.currentUserPhone;
    apiService.findUserByPhone(userId).asStream().listen((user) {
      order.customer = user;
    });

    if (stocks == null) {
      apiService.findAllStockByShopId(shop.id).asStream().listen((resp) {
        stocks = resp;
      }, onError: (e) {
        showError(error: e);
      }, onDone: () {});
    }
  }

  String get search => _search;
  set search(String search) {
    _search = search;
    notifyChanged();
  }

  List<Stock> get matchedStocks => _stocks
      .where((element) =>
          element.name.toLowerCase().contains(search.toLowerCase()))
      .toList();

  void remove(BasketItem basketItem) {
    order.basket.removeOneItem(basketItem);
    stocks.firstWhere((elem) => elem.name == basketItem.name).put(1);
    notifyChanged();

    BaseViewModel.analytics
        .logRemoveFromCart(
            itemCategory: shop.name,
            itemId: "${basketItem.hashCode}",
            itemName: basketItem.name,
            quantity: basketItem.quantity,
            price: basketItem.price)
        .then((value) => null);
  }

  void add(BasketItem basketItem) {
    order.basket.addItem(basketItem);
    notifyChanged();
    BaseViewModel.analytics
        .logAddToCart(
            itemCategory: shop.name,
            itemId: basketItem.name,
            itemName: basketItem.name,
            quantity: basketItem.quantity,
            price: basketItem.price)
        .then((value) => null);
  }

  void verifyItemsAvailable() {
    if (order.basket.getBasketTotalItems() == 0) {
      return;
    }

    if (!isLoggedIn) {
      showLoginMessage(context);
      return;
    }

    if (order.customer == null) {
      var userId = apiService.currentUserPhone;
      progressMv.isBusy = true;
      apiService.findUserByPhone(userId).asStream().listen((user) {
        order.customer = user;
        Navigator.pushNamed(context, DeliveryOptionsView.ROUTE_NAME,
            arguments: order);
        progressMv.isBusy = false;
      });
    } else {
      Navigator.pushNamed(context, DeliveryOptionsView.ROUTE_NAME,
            arguments: order);
    }
  }

  bool get isLoggedIn => storageManager.isLoggedIn;

  List<Stock> get stocks => _stocks;

  set stocks(List<Stock> stocks) {
    _stocks = stocks;
    notifyChanged();
  }
}
