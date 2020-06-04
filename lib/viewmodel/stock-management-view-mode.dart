import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StockManagementViewModel extends BaseViewModel {

  final Shop shop;
  final ApiService apiService;
  List<Stock> _stocks;

  String newItemName;
  String newItemPrice;
  String newItemQuantity;

  StockManagementViewModel({this.shop, @required this.apiService});

  @override
  initialize() {
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

  addNewItem() {
    progressMv.isBusy = true;
    var stock = Stock(
      name: newItemName,
      price: newItemPrice,
      quantity: newItemQuantity);
      
    apiService.addStockItem(shop.id, stock)
        .asStream()
        .listen((event) { 
          newItemName = "";
          newItemQuantity = "";
          newItemPrice = "";
          stocks.add(stock);
          notifyChanged();
        }, onError: (e) {
          hasError = true;
          errorMessage = e.toString();
        }, onDone: () {
          progressMv.isBusy = false;
        });
  }

  List<Stock> get stocks => _stocks;
  set stocks(List<Stock> stocks) {
    _stocks = stocks;
    notifyChanged();
  }
  
}