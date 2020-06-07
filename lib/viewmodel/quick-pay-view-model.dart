import 'dart:async';

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

class QuickPayViewModel extends BaseViewModel {
  final ApiService apiService;
  final UkhesheService ukhesheService;
  final Shop shop;

  Bank _wallet = Bank();
  double payAmount = 0;
  String itemName;
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
          order.shippingData = Shipping();
          order.shippingData.type = ShippingType.COLLECTION;
          order.orderType = OrderType.INSTORE;
          order.shippingData.pickUpTime = TimeOfDay.now();
          order.shippingData.fromAddress = shop.name;
          order.basket = Basket();
          order.description = "Payment from ${order.customer.mobileNumber}";
        }, onError: (e) {
            hasError = true;
            errorMessage = e.toString();
        },
         onDone: () {});
  }

  String get baseUrl => UkhesheService.baseURL;
  
  Bank get wallet => _wallet;
  set wallet(Bank wallet) {
    _wallet = wallet;
    notifyChanged();
  }

  pay() {
    progressMv.isBusy = true;
    apiService.startOrder(order).asStream()
      .map((newOrder) {
        order.id = newOrder.id;
        order.date = newOrder.date;
        order.paymentType = PaymentType.UKHESHE;
        order.hasVat = newOrder.hasVat;
        order.description = "Payment from ${order.customer.mobileNumber} order ${order.id}";
      })
      .asyncExpand((event) => ukhesheService.paymentForOrder(order).asStream())
      .asyncExpand((event) => Future.delayed(Duration(seconds: 4)).asStream())
      .asyncExpand((event) => apiService.completeOrderPayment(order).asStream()
        )
      .listen((data) {
      Navigator.popAndPushNamed (
            context,
            ReceiptView.ROUTE_NAME,
            arguments: order);
    }, onError: (e) {
      hasError = true;
      errorMessage = e.toString();
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
    BasketItem basketItem =
        BasketItem(name: itemName, 
          price: payAmount, 
          quantity: quantity,
          discountPerc: 0);
    order.basket.addItem(basketItem);
    return order.customer.bank.availableBalance < order.totalAmount;
  }
}
