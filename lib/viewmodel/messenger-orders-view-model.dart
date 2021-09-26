import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/order-status-checker.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MessengerOrdersViewModel extends BaseViewModel with OrderStatusChecker {
  
  List<Order>? _orders = [];
  final ApiService apiService;
  final String? messengerId;

  MessengerOrdersViewModel(
      {required this.apiService, required this.messengerId});

  @override
  void initialize() {
    apiService.findOrdersByMessengerId(messengerId).asStream().listen((respo) {
      orders = respo;
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {});

    startOrdersStatusCheck(messengerId: messengerId);
  }

  @override
  List<Order>? get orders => _orders;

  @override
  set orders(List<Order>? orders) {
    _orders = orders;
    notifyChanged();
  }

  bool isStoreDone(Order order) {
    return OrderStage.STAGE_0_CUSTOMER_NOT_PAID != order.stage &&
        OrderStage.STAGE_1_WAITING_STORE_CONFIRM != order.stage &&
        OrderStage.STAGE_2_STORE_PROCESSING != order.stage;
  }

  @override
  void dispose() {
    super.destroy();
    super.dispose();
  }
}
