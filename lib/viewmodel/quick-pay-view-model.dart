import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/topup-status-checker.dart';
import 'package:ijudi/view/quick-payment-success.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class QuickPayViewModel extends BaseViewModel with TopTupStatusChecker {
  final ApiService apiService;
  final UkhesheService ukhesheService;
  final Shop shop;
  UserProfile customer;

  double _payAmount = 0;

  String _itemName = "";
  Order order = Order();
  int quantity = 1;
  bool paymentSuccessful;

  QuickPayViewModel({this.apiService, this.ukhesheService, this.shop});

  @override
  initialize() {
    var userId = apiService.currentUserPhone;
    ukhesheService
        .getAccountInformation()
        .asStream()
        .map((resp) => wallet = resp)
        .asyncExpand((wallet) => apiService.findUserByPhone(userId).asStream())
        .listen((cust) {
            customer = cust;
            cust.bank = wallet;
            fetchPaymentCards().onData((data) {
              this.paymentCards = data;
            });
            generateAddPaymentCardUrl();
    }, onError: (e) {
      showError(error: e);
    }, onDone: () {});
  }

  String get baseUrl => ukhesheService.baseUrl;

  String get itemName => _itemName;
  set itemName(String itemName) {
    _itemName = itemName;
    notifyChanged();
  }

  double get payAmount => _payAmount;
  set payAmount(double payAmount) {
    _payAmount = payAmount;
    topupAmount = "$payAmount";
  }

  pay() {
    progressMv.isBusy = true;
    ukhesheService.paymentForOrder(order).asStream().asyncExpand((event) {
      HapticFeedback.vibrate();
      paymentSuccessful = true;
      return apiService.completeOrderPayment(order).asStream();
    }).listen((data) {
      BaseViewModel.analytics
          .logEcommercePurchase(
              transactionId: order.id,
              value: order.totalAmount,
              currency: "ZAR")
          .then((value) => {});

      Navigator.popAndPushNamed(context, ReceiptView.ROUTE_NAME,
          arguments: order);
    }, onError: (e) {
      clearOrder();
      showError(error: e);

      var failedPaymentLeg = paymentSuccessful
          ? "error.order.purchase.leg.1"
          : "error.order.payment.verify";
      BaseViewModel.analytics.logEvent(name: failedPaymentLeg, parameters: {
        "shop": order.shop.name,
        "order": order.id,
        "error": e.toString()
      }).then((value) => {});
    }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  bool get isBalanceLow {
    return order.customer.bank.availableBalance < order.totalAmount;
  }

  StreamSubscription startOrder() {
    progressMv.isBusy = true;
    order = new Order();
    order.customer = customer;
    order.shop = shop;
    order.orderType = OrderType.INSTORE;
    order.basket = Basket();
    order.description = "Payment from ${order.customer.mobileNumber}";
    order.basket.clear();
    var basketItem =
        BasketItem(name: itemName, quantity: quantity, price: payAmount);
    order.basket.addItem(basketItem);
    var subscr = apiService.startOrder(order).asStream().map((newOrder) {
      var oldOrder = order;
      order = newOrder;
      order.customer = oldOrder.customer;
      order.shop = oldOrder.shop;
      order.description =
          "Payment from ${order.customer.mobileNumber}: order ${order.id}";
      log("reference is ${order.description}");
    }).listen(null);

    subscr.onError((error) {
      showError(error: error);
      clearOrder();
      hasError = true;
    });

    subscr.onDone(() => progressMv.isBusy = false);
    return subscr;
  }

  clearOrder() {
    order.basket.clear();
  }

  bool itemsSelected() {
    var items = itemName.split(", ").toSet();
    return shop.tags.intersection(items).length > 0;
  }
}
