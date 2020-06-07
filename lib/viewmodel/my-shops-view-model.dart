import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/view/stock-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MyShopsViewModel extends BaseViewModel {
  
  Shop _shop;
  ApiService apiService;

  MyShopsViewModel({@required this.apiService});

  @override
  void initialize() {
    shop = Shop.createPlaceHolder();
    apiService.findShopById("42b2e967-d653-4085-a7b7-ef20301acec8")
      .asStream()
      .listen((shp) {
        shop = shp;
      }
      ,onError: (e) {
        hasError = true;
        errorMessage = e.toString();
      });
  }

  void updateProfile() {
    progressMv.isBusy = true;
    apiService.updateShop(shop)
      .asStream()
      .listen((resp) {
        Navigator.pushNamed(context, StockManagementView.ROUTE_NAME, arguments: _shop);
      },onDone: () {
        progressMv.isBusy = false;
      });
  }

  Shop get shop => _shop;
  set shop(Shop shop) {
    _shop = shop;
    notifyChanged();
  }

  String get address => _shop.address;
  set address(String address) {
    _shop.address = address;
    notifyChanged();
  }
}
