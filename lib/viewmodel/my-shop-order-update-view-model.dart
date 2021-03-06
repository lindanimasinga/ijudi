import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/my-shop-orders.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MyShopOrderUpdateViewModel extends BaseViewModel {
  Order _order;

  final ApiService apiService;
  UserProfile _customer;

  MyShopOrderUpdateViewModel({@required Order order, @required this.apiService})
      : this._order = order;

  @override
  initialize() {
    this
        .apiService
        .findUserById(order.customerId)
        .asStream()
        .listen((customer) {
      this.customer = customer;
    });
  }

  get orderReadyForCollection =>
      Utils.onlineDeliveryStages[order.stage] >=
      Utils.onlineDeliveryStages[OrderStage.STAGE_3_READY_FOR_COLLECTION];

  get orderType => order.shippingData != null
      ? describeEnum(order.shippingData.type)
      : describeEnum(order.orderType);

  bool get isInstoreOrder => order.orderType == OrderType.INSTORE;

  bool get isDelivery => ShippingType.DELIVERY == order.shippingData.type;

  UserProfile get customer => _customer;

  set customer(UserProfile customer) {
    _customer = customer;
    notifyChanged();
  }

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

      BaseViewModel.analytics
          .logEvent(name: "order.status.changed", parameters: {
        "shop": order.shopId,
        "orderId": order.id,
        "Delivery": order.shippingData.type,
        "stage": order.shippingData.type
      }).then((value) => {});

      if (order.stage == OrderStage.STAGE_3_READY_FOR_COLLECTION) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, MyShopOrdersView.ROUTE_NAME,
            arguments: order.shopId);
      }
    }, onError: (e) {
      showError(error: e);
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
