import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ShopProfileViewModel extends BaseViewModel {
  
  final Shop shop;
  ApiService apiService;

  ShopProfileViewModel({@required this.shop, @required this.apiService});

  void updateProfile() {
    progressMv.isBusy = true;
    apiService.updateShop(shop)
      .asStream()
      .listen((resp) {
        Navigator.pop(context);
      }, onDone: () {
        progressMv.isBusy = false;
      });
  }

  String get address => shop.address;
  set address(String address) {
    shop.address = address;
    notifyChanged();
  }
}
