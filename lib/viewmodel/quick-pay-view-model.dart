import 'dart:async';

import 'package:flutter/services.dart';
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

class QuickPayViewModel extends BaseViewModel with TopTupStatusChecker{
  final ApiService apiService;
  final UkhesheService ukhesheService;
  final Shop shop;

  Bank _wallet = Bank();
  double payAmount = 0;
  String _itemName = "";
  double topupAmount = 0;
  Order order = Order();
  int quantity = 1;

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
          order.customer = cust;
          cust.bank = wallet;
          order.shop = shop;
          order.orderType = OrderType.INSTORE;
          order.basket = Basket();
          order.description = "Payment from ${order.customer.mobileNumber}";
        }, onError: (e) {
                  showError(error: e);
        },
         onDone: () {});
  }

  String get baseUrl => ukhesheService.baseUrl;
  
  Bank get wallet => _wallet;
  set wallet(Bank wallet) {
    _wallet = wallet;
    notifyChanged();
  }

  String get itemName => _itemName;
  set itemName(String itemName) {
    _itemName = itemName;
    notifyChanged();
  }

  pay() {
    progressMv.isBusy = true;
    ukhesheService.paymentForOrder(order).asStream()
      .asyncExpand((event) {
        HapticFeedback.vibrate();
        return apiService.completeOrderPayment(order).asStream();
      })
      .listen((data) {
        BaseViewModel.analytics
        .logEcommercePurchase(
          transactionId: order.id,
          value: order.totalAmount,
          currency: "ZAR"
        ).then((value) => {});
        
        Navigator.popAndPushNamed (
              context,
              ReceiptView.ROUTE_NAME,
              arguments: order);
      }, onError: (e) {
        clearOrder();
          showError(error: e);

        BaseViewModel.analytics
          .logEvent(
            name: "order-purchase-failed",
            parameters: {
              "shop" : order.shop.name,
              "error" : e.toString()
            })
          .then((value) => {});
      }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  StreamSubscription<InitTopUpResponse> topUp() {
    //progressMv.isBusy = true;
    var sub  = ukhesheService
        .initiateTopUp(wallet.customerId, topupAmount, null)
        .asStream()
        .listen(null);
    sub.onDone(() {
      //progressMv.isBusy = false;
    });
    return sub;    
  }

  fetchNewAccountBalances() {
    var userId = apiService.currentUserPhone;
    progressMv.isBusy = true;
    ukhesheService
        .getAccountInformation()
        .asStream()
        .map((resp) => wallet = resp)
        .asyncExpand((wallet) => apiService.findUserByPhone(userId).asStream())
        .listen((cust) {
          cust.bank = wallet;
        }, onDone: () => progressMv.isBusy = false);
  }

  bool get isBalanceLow {
    return order.customer.bank.availableBalance < order.totalAmount;
  }

  StreamSubscription startOrder() {
    progressMv.isBusy = true;
    var basketItem = BasketItem(name: itemName, quantity: quantity, price: payAmount);
    order.basket.addItem(basketItem);
    var subscr = apiService.startOrder(order).asStream()
      .map((newOrder) {
        order.id = newOrder.id;
        order.date = newOrder.date;
        order.paymentType = PaymentType.UKHESHE;
        order.hasVat = newOrder.hasVat;
        order.serviceFee = newOrder.serviceFee;
        order.description = "Payment from ${order.customer.mobileNumber} order ${order.id}";
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
