import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ijudi/util/topup-status-checker.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class PaymentViewModel extends BaseViewModel with TopTupStatusChecker {
  final Order order;
  final ApiService apiService;
  final UkhesheService ukhesheService;
  String topupAmount;
  bool paymentSuccessful = false;

  PaymentViewModel(
      {@required this.apiService,
      @required this.order,
      @required this.ukhesheService});

  @override
  void initialize() {}

  set availableBalance(CustomerInfoResponse value) {
    order.customer.bank = value;
    print(order.customer.bank);
    print(order.customer.bank.currentBalance);
    order.customer.bank.currentBalance =
        order.customer.bank.currentBalance == null
            ? 0
            : order.customer.bank.currentBalance;
    order.customer.bank.availableBalance =
        order.customer.bank.availableBalance == null
            ? 0
            : order.customer.bank.availableBalance;
    notifyChanged();
  }

  bool get isBalanceLow =>
      order.customer.bank.availableBalance < order.totalAmount;

  String get baseUrl => ukhesheService.baseUrl;

  String get collectionInstructions =>
      "Please produce your order number ${order.id} when collecting your order at ${order.shop.name}. Contact Number : ${order.shop.mobileNumber}";

  String get deliveryHeader => isDelivery ? "Delivery By" : "Collection";

  bool get isDelivery => order.shippingData.type == ShippingType.DELIVERY;

  get paymentType => order.paymentType;

  set paymentType(PaymentType paymentType) {
    order.paymentType = paymentType;
    notifyChanged();
  }

  StreamSubscription<InitTopUpResponse> topUp() {
    progressMv.isBusy = true;
    var sub = ukhesheService
        .initiateTopUp(
            order.customer.bank.customerId, double.parse(topupAmount), order.id)
        .asStream()
        .listen(null);
    sub.onDone(() {
      progressMv.isBusy = false;
    });
    return sub;
  }

  fetchNewAccountBalances() {
    progressMv.isBusy = true;
    ukhesheService.getAccountInformation().asStream().listen((resp) {
      availableBalance = resp;
    }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  processPayment() {
    progressMv.isBusy = true;
    var stream = paymentSuccessful
        ? Stream.value(0)
        : ukhesheService.paymentForOrder(order).asStream();
    stream.asyncExpand((event) {
      HapticFeedback.vibrate();
      return Future.delayed(Duration(seconds: 2)).asStream();
    }).asyncExpand((event) {
      order.paymentType = PaymentType.UKHESHE;
      paymentSuccessful = true;
      return apiService.completeOrderPayment(order).asStream();
    }).listen((data) {
      order.stage = data.stage;

      BaseViewModel.analytics
          .logEcommercePurchase(
              transactionId: order.id,
              value: order.totalAmount,
              currency: "ZAR")
          .then((value) => {});

      BaseViewModel.analytics.logEvent(
        name: "order.purchase.leg.1", 
        parameters: {
        "shop": order.shop.name,
        "Order Id": order.id,
        "Delivery": order.shippingData.type,
        "Total Amount": order.totalAmount
      }).then((value) => {});

      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: order);
    }, onError: (e) {
      showError(error: e.toString());

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

  processCashPayment() {
    progressMv.isBusy = true;
    var subscr = apiService.completeOrderPayment(order).asStream().listen(null);

    subscr.onData((data) {
      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: order);
    });

    subscr.onDone(() {
      progressMv.isBusy = false;
    });
  }
}
