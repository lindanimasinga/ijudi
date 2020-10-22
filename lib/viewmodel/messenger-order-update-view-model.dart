import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ijudi/view/messenger-orders.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class MessengerOrderUpdateViewModel extends BaseViewModel {
  Order _order;
  Shop _shop;
  double _currentLatitude = Config.currentConfig.centreLatitude;
  double _currentLongitude = Config.currentConfig.centrelongitude;

  final ApiService apiService;

  double _customerLatitude = Config.currentConfig.centreLatitude;
  double _customerLongitude = Config.currentConfig.centrelongitude;

  double _shopLatitude = Config.currentConfig.centreLatitude;
  double _shopLongitude = Config.currentConfig.centrelongitude;

  UserProfile _customer;

  MessengerOrderUpdateViewModel(
      {@required Order order, @required this.apiService})
      : this._order = order;

  List<double> get latBounds =>
      [_customerLatitude, _currentLatitude, shopLatitude]..sort();

  List<double> get lngBounds =>
      [_customerLongitude, _currentLongitude, shopLongitude]..sort();

  @override
  initialize() {
    Rx.merge([
      this.apiService.findShopById(order.shopId).asStream().map((resp) {
        shop = resp;
        shopLatitude = shop.latitude;
        shopLongitude = shop.longitude;
      }),
      this.apiService.findUserById(order.customerId).asStream().map((resp) {
        customer = resp;
      }),
      getLastKnownPosition()
          .asStream()
          .map((position) {
        currentLatitude = position.latitude;
        currentLongitude = position.longitude;
      }),
      locationFromAddress(order.shippingData.toAddress)
          .asStream()
          .map((placeMark) {
        customerLatitude = placeMark[0].latitude;
        customerLongitude = placeMark[0].longitude;
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

      BaseViewModel.analytics.logEvent(name: "order.status.changed", parameters: {
        "shop": order.shopId,
        "orderId": order.id,
        "Delivery": order.shippingData.type,
        "stage": order.shippingData.type
      }).then((value) => {});

      if (order.stage == OrderStage.STAGE_6_WITH_CUSTOMER) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, MessengerOrdersView.ROUTE_NAME,
            arguments: order.shippingData.messengerId);
      }
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  UserProfile get customer => _customer;

  set customer(UserProfile customer) {
    _customer = customer;
    notifyChanged();
  }

  double get shopLatitude => _shopLatitude;
  set shopLatitude(double shopLatitude) {
    _shopLatitude = shopLatitude;
    notifyChanged();
  }

  double get shopLongitude => _shopLongitude;
  set shopLongitude(double shopLongitude) {
    _shopLongitude = shopLongitude;
    notifyChanged();
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
