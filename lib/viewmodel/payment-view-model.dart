import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class PaymentViewModel extends BaseViewModel {
  
  final Order order;
  final UkhesheService ukhesheService;
  String topupAmount;

  PaymentViewModel({@required this.order, @required this.ukhesheService});

  @override
  void initialize() {
  }

  processPayment() {
    progressMv.isBusy = true;
    var subscr = ukhesheService.paymentForOrder(order).asStream().listen(null);
    
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
}
