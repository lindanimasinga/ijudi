import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import '../util/order-status-checker.dart';

class PaymentViewModel extends BaseViewModel with OrderStatusChecker {
  bool paymentSuccessful = false;

  PaymentViewModel({required ApiService apiService, required Order order}) {
    this.apiService = apiService;
    this.currentOrder = order;
  }

  @override
  void initialize() {
    startOrderStatusCheck();
  }

  get paymentUrl => Config.currentConfig?.paymentUrl;

  bool get isBalanceLow =>
      (currentOrder.customer?.bank?.availableBalance ?? 0) <
      (currentOrder.totalAmount ?? 0);

  String get collectionInstructions =>
      "Please produce your order number ${currentOrder.id} when collecting your order at ${currentOrder.shop?.name}. Contact Number : ${currentOrder.shop?.mobileNumber}";

  String get deliveryHeader => isDelivery ? "Delivery By" : "Delivery on";

  bool get isDelivery => currentOrder.shippingData?.type == ShippingType.DELIVERY;

  PaymentType? get paymentType => currentOrder.paymentType;

  Bank? get wallet => currentOrder.customer?.bank;

  set paymentType(PaymentType? paymentType) {
    currentOrder.paymentType = paymentType;
    notifyChanged();
  }

  @override
  notifyChanged() {
    if (currentOrder.stage != OrderStage.STAGE_0_CUSTOMER_NOT_PAID) {
      BaseViewModel.analytics.logPurchase(
          value: currentOrder.totalAmount ?? 0.0,
          currency: "ZAR");

      BaseViewModel.analytics.logEvent(name: "order.purchase.leg.1", parameters: {
        "shop": currentOrder.shop?.name ?? "",
        "Order Id": currentOrder.id ?? "",
        "Delivery": currentOrder.shippingData?.type.toString() ?? "",
        "Total Amount": currentOrder.totalAmount ?? 0.0
      });

      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: currentOrder);
    }
  }

  processPayment() {
    progressMv?.isBusy = true;
    var stream = Stream.value(0);
    stream.asyncExpand((event) {
      HapticFeedback.vibrate();
      return Future.delayed(Duration(seconds: 2)).asStream();
    }).asyncExpand((event) {
      currentOrder.paymentType = PaymentType.YOCO;
      paymentSuccessful = true;
      return apiService.completeOrderPayment(currentOrder).asStream();
    }).listen((data) {
      currentOrder.stage = data.stage;

      BaseViewModel.analytics.logPurchase(
          value: currentOrder.totalAmount ?? 0.0,
          currency: "ZAR");

      BaseViewModel.analytics.logEvent(name: "order.purchase.leg.1", parameters: {
        "shop": currentOrder.shop?.name ?? "",
        "Order Id": currentOrder.id ?? "",
        "Delivery": currentOrder.shippingData?.type.toString() ?? "",
        "Total Amount": currentOrder.totalAmount ?? 0.0
      });

      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: currentOrder);
    }, onError: (e) {
      showError(error: e.toString());

      var failedPaymentLeg = paymentSuccessful
          ? "error.order.purchase.leg.1"
          : "error.order.payment.verify";
      BaseViewModel.analytics.logEvent(name: failedPaymentLeg, parameters: {
        "shop": currentOrder.shop?.name ?? "",
        "order": currentOrder.id ?? "",
        "error": e.toString()
      });
    }, onDone: () {
      progressMv?.isBusy = false;
    });
  }

  processCashPayment() {
    progressMv?.isBusy = true;
    var subscr =
        apiService.completeOrderPayment(currentOrder).asStream().listen(null);

    subscr.onData((data) {
      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: currentOrder);
    });

    subscr.onDone(() {
      progressMv?.isBusy = false;
    });
  }

  processPOSPayment() {
    progressMv?.isBusy = true;

    currentOrder.paymentType = PaymentType.SPEED_POINT;
    paymentSuccessful = true;
    var subscr =
        apiService.completeOrderPayment(currentOrder).asStream().listen(null);
    subscr.onData((data) {
      BaseViewModel.analytics.logPurchase(
          value: currentOrder.totalAmount ?? 0.0,
          currency: "ZAR");
      Navigator.pushNamedAndRemoveUntil(
          context, FinalOrderView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: currentOrder);
    });

    subscr.onDone(() {
      progressMv?.isBusy = false;
    });
  }

  @override
  void dispose() {
    destroy();
    super.dispose();
  }
}
