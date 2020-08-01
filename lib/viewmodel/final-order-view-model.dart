import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FinalOrderViewModel extends BaseViewModel {
  final Order order;
  final Shop shopPlaceHolder = Utils.createPlaceHolder();

  final ApiService apiService;
  final NotificationService localNotificationService;

  FinalOrderViewModel(
      {@required this.order,
      @required this.apiService,
      @required this.localNotificationService});

  @override
  void initialize() {
    if (order.shop != null) {
      var dateTime = DateTime.now().add(Duration(minutes: 10));
      localNotificationService
          .scheduleLocalMessage(dateTime, "${order.shop.name}",
              "Dont forget about your order. Please check progress in the app.")
          .asStream()
          .listen((event) {});

      dateTime = DateTime.now().add(Duration(minutes: 20));
      localNotificationService
          .scheduleLocalMessage(dateTime, "${order.shop.name}",
              "Dont forget about your order. Please check progress in the app.")
          .asStream()
          .listen((event) {});
    }

    if (order.shop == null) {
      apiService
          .findShopById(order.shopId)
          .asStream()
          .listen((shp) => shop = shp, onError: (e) {
        showError(error: e);
      });
    }
  }

  Shop get shop => order.shop == null ? shopPlaceHolder : order.shop;
  set shop(Shop shop) {
    order.shop = shop;
    notifyChanged();
  }

  void moveNextStage() {
    notifyChanged();
  }

  OrderStage get stage => order.stage;
}
