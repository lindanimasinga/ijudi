import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/business-hours.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:intl/intl.dart';

class StartShoppingViewModel extends BaseViewModel with MessageDialogs {
  final Shop? shop;
  final ApiService apiService;

  StartShoppingViewModel({this.shop, required this.apiService});

  List<Stock>? _stocks;
  Order? order;
  String _search = "";

  @override
  void initialize() {
    BaseViewModel.analytics
        .logViewItemList(itemListName: shop!.name!)
        .then((value) => null);

    order = Order();
    order!.shop = shop;
    order!.description = "order from ${shop!.name}";
    stocks = shop!.stockList;

    var userId = apiService.currentUserPhone;
    if (userId != null) {
      apiService.findUserByPhone(userId).asStream().listen((user) {
        order!.customer = user;
      });
    }

    if (stocks == null) {
      apiService.findAllStockByShopId(shop!.id).asStream().listen((resp) {
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

  Map<String?, List<Stock>> get stockGroup {
    var map = new Map<String?, List<Stock>>();
    matchedStocks.forEach((item) {
      item.group = item.group == null ? "Items" : item.group;
      var stockList = map[item.group];
      if (map[item.group] == null) {
        stockList = <Stock>[];
        map[item.group] = stockList;
      }
      stockList!.add(item);
    });
    return map;
  }

  List<Stock> get matchedStocks => _stocks!
      .where((element) =>
          element.name!.toLowerCase().contains(search.toLowerCase()))
      .toList();

  void remove(BasketItem basketItem) {
    order!.basket!.removeOneItem(basketItem);
    stocks!.firstWhere((elem) => elem.name == basketItem.name).put(1);
    notifyChanged();

    BaseViewModel.analytics
        .logRemoveFromCart(
            items: [
            AnalyticsEventItem(itemCategory: shop!.name!,
            itemId: "${basketItem.hashCode}",
            itemName: basketItem.name!,
            quantity: basketItem.quantity!)],
            currency: "ZAR",
            value: basketItem.price)
        .then((value) => null);
  }

  void add(BasketItem basketItem) {
    order!.basket!.addItem(basketItem);
    notifyChanged();
    BaseViewModel.analytics
        .logAddToCart(
          items: [
            AnalyticsEventItem(
            itemCategory: shop!.name!,
            itemId: basketItem.name!,
            itemName: basketItem.name!,
            quantity: basketItem.quantity!)],
            currency: "ZAR",
            value: basketItem.price)
        .then((value) => null);
  }

  void verifyItemsAvailable() {
    if (order!.basket!.getBasketTotalItems() == 0) {
      return;
    }
    Navigator.pushNamed(context, DeliveryOptionsView.ROUTE_NAME,
        arguments: order);
  }

  List<Stock>? get stocks => _stocks;

  set stocks(List<Stock>? stocks) {
    _stocks = stocks;
    notifyChanged();
  }

  BusinessHours get nextOpenTime {
    var index = shop!.businessHours.indexWhere((day) =>
        DateFormat('EEEE').format(DateTime.now()).toUpperCase() ==
        describeEnum(day.day));
    var nextOpenDayIndex =
        index >= shop!.businessHours.length - 1 ? 0 : index + 1;
    return shop!.businessHours.elementAt(nextOpenDayIndex);
  }
}
