import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/util.dart';
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
      showError(error: e);
    }, onDone: () {
    });
  }

  List<Order> get orders => _orders;

  set orders(List<Order> orders) {
    _orders = orders;
    notifyChanged();
  }

  bool pickUpTimeWithInAnHour(TimeOfDay pickUpTime) {
    var pickUpDateTime = Utils.timeOfDayAsDateTime(pickUpTime);
    var anHourAgo = DateTime.now().subtract(Duration(hours: 1));
    return pickUpDateTime.isAtSameMomentAs(anHourAgo) || pickUpDateTime.isBefore(anHourAgo);
  }
}
