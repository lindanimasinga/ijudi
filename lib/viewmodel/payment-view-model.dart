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
  initialize() {
    ukhesheService.getAccountInformation()
      .listen((resp) {
        availableBalance = resp;
      });
  }

  processPayment() {
    progressMv.isBusy = true;
    var subscr = ukhesheService.paymentForOrder(order).listen(null);
    subscr.onData((data) => progressMv.isBusy = false);
    subscr.onDone(() {
      progressMv.isBusy = false;
      //pretends its successful.. testing only
      Navigator.pushNamedAndRemoveUntil(
            context,
            FinalOrderView.ROUTE_NAME,
            (Route<dynamic> route) => false,
            arguments: order);
    });
  }

  set availableBalance(CustomerInfoResponse value) {
    order.busket.customer.bank = value;
    print(order.busket.customer.bank);
    print(order.busket.customer.bank.currentBalance);
    order.busket.customer.bank.currentBalance =
      order.busket.customer.bank.currentBalance == null? 0 : order.busket.customer.bank.currentBalance;
    order.busket.customer.bank.availableBalance =
      order.busket.customer.bank.availableBalance == null? 0 : order.busket.customer.bank.availableBalance;
    notifyChanged();
  }

  bool get isBalanceLow => order.busket.customer.bank.availableBalance < order.totalAmount;

  String get baseUrl => UkhesheService.baseURL;

  StreamSubscription<InitTopUpResponse> topUp() {
    progressMv.isBusy = true;
    var sub  = ukhesheService
        .initiateTopUp(order.customer.bank.customerId, double.parse(topupAmount), order.id)
        .listen(null);
    sub.onDone(() {
      progressMv.isBusy = false;
    });
    return sub;    
  }

  fetchNewAccountBalances() {
    progressMv.isBusy = true;
    ukhesheService.getAccountInformation()
      .listen((resp) {
        availableBalance = resp;
      },
      onDone: () {
        progressMv.isBusy = false;
      });
  }
}
