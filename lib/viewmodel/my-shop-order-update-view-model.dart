import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/my-shop-orders.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

import '../config.dart';

class MyShopOrderUpdateViewModel extends BaseViewModel {
  Order _order;
  final ApiService apiService;
  UserProfile? _customer;
  List<UserProfile> _messengers = [];
  UserProfile? _selectedMessenger;

  MyShopOrderUpdateViewModel({required Order order, required this.apiService})
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

    this.apiService
        .findShopById(order.shopId)
        .asStream()
        .asyncExpand((shop) => this
            .apiService
            .findNearbyMessangers(shop.latitude!, shop.longitude!,
                Config.currentConfig!.rangeMap["15km"])
            .asStream())
        .listen((messengers) {
      this.messengers = messengers;
      _selectedMessenger = messengers.firstWhere(
          (m) => m.id == this.order.shippingData?.messengerId,
          orElse: () => UserProfile.empty());
    });
  }

  get orderReadyForCollection =>
      Utils.onlineDeliveryStages[order.stage!]! >=
      Utils.onlineDeliveryStages[OrderStage.STAGE_3_READY_FOR_COLLECTION]!;

  get orderType => order.shippingData != null
      ? describeEnum(order.shippingData!.type!)
      : describeEnum(order.orderType!);

  bool get isInstoreOrder => order.orderType == OrderType.INSTORE;

  bool get isDelivery => ShippingType.DELIVERY == order.shippingData!.type;

  UserProfile? get customer => _customer;

  set customer(UserProfile? customer) {
    _customer = customer;
    notifyChanged();
  }

  List<UserProfile> get messengers => _messengers;

  set messengers(List<UserProfile> messengers) {
    _messengers = messengers;
    notifyChanged();
  }

  UserProfile? get selectedMessenger => _selectedMessenger;

  set selectedMessenger(UserProfile? selectedMessenger) {
    _selectedMessenger = selectedMessenger;
    order.shippingData?.messengerId = selectedMessenger?.id;
    updateMessengerForOrder(this.order, selectedMessenger!);
    notifyChanged();
  }

  updateMessengerForOrder(Order order, UserProfile messenger) {
    apiService
        .reassignOrder(order.id!, messenger.mobileNumber!)
        .asStream()
        .listen((event) {
      showError(error: "${messenger.name} will now be delivering this order.");
    }, onError: (e) {
      showError(error: e);
    });
  }

  rejectOrder() {
    if(progressMv?.mounted == true) {
      progressMv?.isBusy = true;
    }
    apiService.cancelOrder(order.id!).asStream()
        .listen((event) {
        Navigator.pop(context);
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {
      if(progressMv?.isBusy) {
        progressMv?.isBusy = progressMv?.isBusy;
      }
    });
  }

  progressNextStage() {
    progressMv!.isBusy = true;
    apiService.progressOrderNextStage(order.id).asStream().listen((data) {
      order = data;

      BaseViewModel.analytics
          .logEvent(name: "order.status.changed", parameters: {
        "shop": order.shopId,
        "orderId": order.id,
        "Delivery": order.shippingData!.type,
        "stage": order.shippingData!.type
      }).then((value) => {});

      if (order.stage == OrderStage.STAGE_3_READY_FOR_COLLECTION) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, MyShopOrdersView.ROUTE_NAME,
            arguments: order.shopId);
      }
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {
      progressMv!.isBusy = false;
    });
  }

  Order get order => _order;
  set order(Order order) {
    _order = order;
    notifyChanged();
  }
}
