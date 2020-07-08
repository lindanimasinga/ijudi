import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MyShopsViewModel extends BaseViewModel {
  
  List<Shop> _shops = [];

  ApiService apiService;

  MyShopsViewModel({@required this.apiService});

  @override
  void initialize() {
    var userId = apiService.currentUserId;
    apiService.findShopByOwnerId(userId)
      .asStream()
      .listen((shp) {
        shops = shp;
      }
      ,onError: (e) {
          showError(messege: e.toString());
      });
  }

  List<Shop> get shops => _shops;
  set shops(List<Shop> shops) {
    _shops = shops;
    notifyChanged();
  }
}
