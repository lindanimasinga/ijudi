import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class PaymentViewModel extends BaseViewModel {
  final Order? order;
  final ApiService apiService;
  String? topupAmount;
  bool paymentSuccessful = false;

  PaymentViewModel(
      {required this.apiService,
      required this.order});

  get paymentUrl => Config.currentConfig!.paymentUrl;

  @override
  void initialize() {}

  bool get isBalanceLow =>
      order!.customer!.bank!.availableBalance! < order!.totalAmount!;

  String get collectionInstructions =>
      "Please produce your order number ${order!.id} when collecting your order at ${order!.shop!.name}. Contact Number : ${order!.shop!.mobileNumber}";

  String get deliveryHeader => isDelivery ? "Delivery By" : "Delivery on";

  bool get isDelivery => order!.shippingData!.type == ShippingType.DELIVERY;

  PaymentType? get paymentType => order!.paymentType;

  Bank? get wallet => order!.customer!.bank;

  set paymentType(PaymentType? paymentType) {
    order!.paymentType = paymentType;
    notifyChanged();
  }

  processPayment() {
    progressMv!.isBusy = true;
    var stream = Stream.value(0);
    stream.asyncExpand((event) {
      HapticFeedback.vibrate();
      return Future.delayed(Duration(seconds: 2)).asStream();
    }).asyncExpand((event) {
      order!.paymentType = PaymentType.PAYFAST;
      paymentSuccessful = true;
      return apiService.completeOrderPayment(order!).asStream();
    }).listen((data) {
      order!.stage = data.stage;

      BaseViewModel.analytics
          .logEcommercePurchase(
              transactionId: order!.id,
              value: order!.totalAmount,
              currency: "ZAR")
          .then((value) => {});

      BaseViewModel.analytics
          .logEvent(name: "order.purchase.leg.1", parameters: {
        "shop": order!.shop!.name,
        "Order Id": order!.id,
        "Delivery": order!.shippingData!.type,
        "Total Amount": order!.totalAmount
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
        "shop": order!.shop!.name,
        "order": order!.id,
        "error": e.toString()
      }).then((value) => {});
    }, onDone: () {
      progressMv!.isBusy = false;
    });
  }

  processCashPayment() {
    progressMv!.isBusy = true;
    var subscr = apiService.completeOrderPayment(order!).asStream().listen(null);

    subscr.onData((data) {
      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: order);
    });

    subscr.onDone(() {
      progressMv!.isBusy = false;
    });
  }
}
