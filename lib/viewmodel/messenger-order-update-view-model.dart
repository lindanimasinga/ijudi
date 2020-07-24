import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/messenger-order-update.dart';
import 'package:ijudi/view/messenger-orders.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class MessengerOrderUpdateViewModel extends BaseViewModel {
  
  Order _order;
  Shop _shop;
  UserProfile customer;
  double _currentLatitude = -29.7380334;
  double _currentLongitude = 30.9553061;

  final ApiService apiService;

  double _customerLatitude = -29.7380334;
  double _customerLongitude = 30.9553061;

  MessengerOrderUpdateViewModel({@required Order order, @required this.apiService})
      : this._order = order;

  @override
  initialize() {
    Rx.merge([
      this.apiService.findShopById(order.shopId).asStream()
      .map((resp) {
        shop = resp;
      }),
      this.apiService.findUserById(order.customerId).asStream()
      .map((resp) {
        customer = resp;
      }),
      Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high).asStream()
      .map((position) {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
      }),
      Geolocator().placemarkFromAddress(order.shippingData.toAddress).asStream()
      .map((placeMark) {
        customerLatitude = placeMark[0].position.latitude;
        customerLongitude = placeMark[0].position.longitude;
      })
    ]).listen((event) {
      log("all location data fetched");
    });

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
      .logEvent(
        name: "store-view-order",
        parameters: {
          "shop" : order.shopId,
          "orderId" : order.id,
          "Delivery" : order.shippingData.type,
          "stage" : order.shippingData.type
        })
      .then((value) => {});

      if (order.stage == OrderStage.STAGE_6_WITH_CUSTOMER) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, MessengerOrdersView.ROUTE_NAME,
            arguments: order.shippingData.messenger.id);
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

  Shop get shop => _shop;
  set shop(Shop shop) {
    _shop = shop;
    notifyChanged();
  }

  double get currentLongitude => _currentLongitude;
  set currentLongitude(double currentLongitude) {
    _currentLongitude = currentLongitude;
    notifyChanged();
  }

  double get currentLatitude => _currentLatitude;
  set currentLatitude(double currentLatitude) {
    _currentLatitude = currentLatitude;
    notifyChanged();
  }

  double get customerLatitude => _customerLatitude;
  set customerLatitude(double customerLatitude) {
    _customerLatitude = customerLatitude;
    notifyChanged();
  }

  double get customerLongitude => _customerLongitude;
  set customerLongitude(double customerLongitude) {
    _customerLongitude = customerLongitude;
    notifyChanged();
  }
}
