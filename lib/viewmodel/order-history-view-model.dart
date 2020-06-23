import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class OrderHistoryViewModel extends BaseViewModel {
  List<Order> _orders = [];
  final ApiService apiService;

  OrderHistoryViewModel({@required this.apiService});

  @override
  void initialize() {
    var userId = apiService.currentUserPhone;
    apiService.findOrdersByPhoneNumber(userId)
    .asStream()
    .listen((respo) {
      orders = respo;
    }, onError: (e) {
      hasError = true;
      errorMessage = e.toString();
    }, onDone: () {
    });

    BaseViewModel.analytics
    .logEvent(name: "customer-view-order")
    .then((value) => {});
  }

  List<Order> get orders => _orders;

  set orders(List<Order> orders) {
    _orders = orders;
    notifyChanged();
  }
}
