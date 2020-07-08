import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MyShopOrdersViewModel extends BaseViewModel {
  List<Order> _orders = [];
  final ApiService apiService;
  final String shopId;

  MyShopOrdersViewModel({@required this.apiService, @required this.shopId});

  @override
  void initialize() {
    apiService.findOrdersByShopId(shopId)
    .asStream()
    .listen((respo) {
      orders = respo;
    }, onError: (e) {
      showError(messege: e.toString());
    }, onDone: () {
    });
  }

  List<Order> get orders => _orders;

  set orders(List<Order> orders) {
    _orders = orders;
    notifyChanged();
  }
}
