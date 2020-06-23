import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StartShoppingViewModel extends BaseViewModel {
  final Shop shop;
  final ApiService apiService;

  StartShoppingViewModel({this.shop, @required this.apiService});

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
    stocks  = shop.stockList;
    var userId = apiService.currentUserPhone;
    apiService.findUserByPhone(userId)
    .asStream()
    .listen((user) {
      order.customer = user;
    });

    if(stocks == null) {
      apiService.findAllStockByShopId(shop.id)
      .asStream()
      .listen((resp) {
        stocks = resp;
      }, onError: (e) {
        hasError = true;
        errorMessage = e.toString(); 
      }, onDone: () {

      });
    }
  }

  String get search => _search;
  set search(String search) {
    _search = search;
    notifyChanged();
  }

  get matchedStocks => _stocks
    .where((element) => element.name.toLowerCase().contains(search.toLowerCase()))
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
      itemId: "${basketItem.hashCode}",
      itemName: basketItem.name, 
      quantity: basketItem.quantity,
      price: basketItem.price)
    .then((value) => null);
  }

  void verifyItemsAvailable() {
    if(order.basket.getBasketTotalItems() == 0) {
      return; 
    }
    progressMv.isBusy = true;
    apiService.verifyCanBuy(order.basket)
    .asStream()
    .listen((data) {
        Navigator.pushNamed(context, DeliveryOptionsView.ROUTE_NAME,
        arguments: order);
    },
    onError: (e) {
      hasError = true;
      errorMessage = e.toString();
    },
    onDone: () => progressMv.isBusy = false);
  }

  List<Stock> get stocks => _stocks;

  set stocks(List<Stock> stocks) {
    _stocks = stocks;
    notifyChanged();
  }
}
