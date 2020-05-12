import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class PaymentViewModel extends BaseViewModel {
  final Order order;

  PaymentViewModel(this.order);

  processPayment() {
    progressMv.isBusy = true;
    var subscr = UkhesheService.paymentForOrder(order).listen(null);
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
}
