import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/my-shop-orders.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MyShopOrderUpdateViewModel extends BaseViewModel {
  
  Order _order;

  final ApiService apiService;

  MyShopOrderUpdateViewModel({@required Order order, @required this.apiService})
      : this._order = order;

  rejectOrder() {
    if (order.stage == OrderStage.STAGE_1_WAITING_STORE_CONFIRM) {
      //reject order
    } else {
      Navigator.pop(context);
    }
  }

  progressNextStage() {
    progressMv.isBusy = true;
    apiService.progressOrderNextStage(order.id).asStream().listen((data) {
      order = data;
      if (order.stage == OrderStage.STAGE_6_WITH_CUSTOMER) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, MyShopOrdersView.ROUTE_NAME,
            arguments: order.shopId);
      }
    }, onError: (e) {
      hasError = true;
      errorMessage = e.toString();
    }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  Order get order => _order;
  set order(Order order) {
    _order = order;
    notifyChanged();
  }
}
