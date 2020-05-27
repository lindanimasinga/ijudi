import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class PaymentViewModel extends BaseViewModel {
  
  final Order order;
  final ApiService apiService;
  final UkhesheService ukhesheService;
  String topupAmount;

  PaymentViewModel({@required this.apiService, 
    @required this.order, @required this.ukhesheService});

  @override
  void initialize() {
  }

  set availableBalance(CustomerInfoResponse value) {
    order.customer.bank = value;
    print(order.customer.bank);
    print(order.customer.bank.currentBalance);
    order.customer.bank.currentBalance =
      order.customer.bank.currentBalance == null? 0 : order.customer.bank.currentBalance;
    order.customer.bank.availableBalance =
      order.customer.bank.availableBalance == null? 0 : order.customer.bank.availableBalance;
    notifyChanged();
  }

  bool get isBalanceLow => order.customer.bank.availableBalance < order.totalAmount;

  String get baseUrl => UkhesheService.baseURL;

  String get collectionInstructions => "Please produce your order number ${order.id} when collecting your order at ${order.shop.name}. Contact Number : ${order.shop.mobileNumber}";

  String get deliveryHeader => isDelivery ? "Delivery By" : "Collection";

  bool get isDelivery => order.shippingData.type == ShippingType.DELIVERY;

  get paymentType => order.paymentType;

  set paymentType(PaymentType paymentType) {
    order.paymentType = paymentType;
    notifyChanged();
  }

  StreamSubscription<InitTopUpResponse> topUp() {
    progressMv.isBusy = true;
    var sub  = ukhesheService
        .initiateTopUp(order.customer.bank.customerId, double.parse(topupAmount), order.id)
        .asStream()
        .listen(null);
    sub.onDone(() {
      progressMv.isBusy = false;
    });
    return sub;    
  }

  fetchNewAccountBalances() {
    progressMv.isBusy = true;
    ukhesheService.getAccountInformation()
      .asStream()
      .listen((resp) {
        availableBalance = resp;
      },
      onDone: () {
        progressMv.isBusy = false;
      });
  }

    processPayment() {
    progressMv.isBusy = true;
    var subscr = ukhesheService.paymentForOrder(order)
      .asStream()
      .asyncExpand((event) => Future.delayed(Duration(seconds: 4)).asStream())
      .asyncExpand((event) {
        order.paymentType = PaymentType.UKHESHE;
        return apiService.completeOrderPayment(order).asStream();
        })
      .listen(null);
    
    subscr.onData((data) {
      Navigator.pushNamedAndRemoveUntil(
            context,
            FinalOrderView.ROUTE_NAME,
            (Route<dynamic> route) => false,
            arguments: order);
    });

    subscr.onDone(() {
      progressMv.isBusy = false;
    });
  }

  processCashPayment() {
    progressMv.isBusy = true;
    var subscr = apiService.completeOrderPayment(order).asStream()
      .listen(null);
    
    subscr.onData((data) {
      Navigator.pushNamedAndRemoveUntil(
            context,
            FinalOrderView.ROUTE_NAME,
            (Route<dynamic> route) => false,
            arguments: order);
    });

    subscr.onDone(() {
      progressMv.isBusy = false;
    });
  }
}