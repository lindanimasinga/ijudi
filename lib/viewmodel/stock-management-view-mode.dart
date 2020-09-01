import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/selection-option.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StockManagementViewModel extends BaseViewModel
    with WidgetsBindingObserver {
  final Shop shop;
  final ApiService apiService;
  List<Stock> _stocks;

  String newItemName;
  double newItemPrice = 0;
  int newItemQuantity = 0;

  List<SelectionOption> options = [];

  StockManagementViewModel({this.shop, @required this.apiService});

  @override
  initialize() {
    WidgetsBinding.instance.addObserver(this);
    apiService.findAllStockByShopId(shop.id).asStream().listen((resp) {
      stocks = resp;
    }, onError: (e) {
      log((e as Error).stackTrace.toString());
      showError(error: e);
    }, onDone: () {});
  }

  addNewItem() {
    progressMv.isBusy = true;
    var stock = Stock(
        name: newItemName, price: newItemPrice, quantity: newItemQuantity);

    apiService.addStockItem(shop.id, stock).asStream().listen((newStock) {
      newItemName = "";
      newItemQuantity = 0;
      newItemPrice = 0;
      stocks.add(stock);
      notifyChanged();
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {
      progressMv.isBusy = false;
    });

    BaseViewModel.analytics
        .logEvent(name: "shop.addStock", parameters: stock.toJson())
        .then((value) => null);
  }

  List<Stock> get stocks => _stocks;
  set stocks(List<Stock> stocks) {
    _stocks = stocks;
    notifyChanged();
  }

  addMoreOptions() {
    options.add(SelectionOption());
    notifyChanged();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("state change");
    switch (state) {
      case AppLifecycleState.resumed:
        log("app in resumed");
        break;
      case AppLifecycleState.inactive:
        log("app in inactive");
        break;
      case AppLifecycleState.paused:
        log("app in paused");
        break;
      case AppLifecycleState.detached:
        log("app in detached");
        break;
    }
  }
}
