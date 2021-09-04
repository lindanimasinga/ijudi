import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-time-input-field.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-review-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/payment-webview.dart';
import 'package:ijudi/viewmodel/payment-view-model.dart';

class PaymentView extends MvStatefulWidget<PaymentViewModel> {
  static const String ROUTE_NAME = "payment";

  PaymentView({@required viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color3,
        title: "Payment",
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Padding(
              padding: EdgeInsets.only(top: 16, left: 0, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text("${viewModel.order!.shop!.name}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, left: 16),
                        child: Text("Order: ${viewModel.order!.id}",
                            style: IjudiStyles.HEADER_TEXT)),
                    OrderReviewComponent(order: viewModel.order),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, top: 16, left: 16),
                        child: Text(viewModel.deliveryHeader,
                            style: IjudiStyles.HEADER_TEXT)),
                    viewModel.isDelivery
                        ? MessagerPreviewComponent(
                            messenger: viewModel.order!.shippingData!.messenger)
                        : Container(
                            alignment: Alignment.topLeft,
                            child: IjudiForm(
                                child: IjudiTimeInput(
                                    hint: "Delivery Time",
                                    enabled: false,
                                    text:
                                        "${Utils.pickUpDay(viewModel.order!.shippingData!.pickUpTime!, context)}"))),
                    paymentWidget(context)
                  ]))
        ]));
  }

  showConfirmPayment(BuildContext context) {
    showMessageDialog(context,
        title: "Confirm Payment",
        actionName: "Pay",
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                "Please click pay to confirm your order of R${viewModel.order!.totalAmount}",
                style: Forms.INPUT_TEXT_STYLE)),
        action: () => viewModel.processPayment());
  }

  showConfirmCashOrder(BuildContext context) {
    showMessageDialog(context,
        title: "Confirm Order",
        actionName: "Confirm",
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                "Please proceed to confirm your order of cash payment amount R${viewModel.order!.totalAmount}.",
                style: Forms.INPUT_TEXT_STYLE)),
        action: () => viewModel.processCashPayment());
  }

  Widget paymentWidget(BuildContext context) {
    var payment;
    double deviceWidth = MediaQuery.of(context).size.width;

    switch (viewModel.paymentType) {
      case PaymentType.PAYFAST:
        payment = Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 24, top: 32),
            child: FloatingActionButtonWithProgress(
              viewModel: viewModel.progressMv,
              onPressed: () {
                payNowWebView(context);
                return;
              },
              child: Icon(Icons.arrow_forward),
            ));
        break;
      case PaymentType.CASH:
        double width = MediaQuery.of(context).size.width > 360 ? 280 : 240;
        payment = Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
                width: width,
                alignment: Alignment.topLeft,
                padding:
                    EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 52),
                child: Text(
                  viewModel.collectionInstructions,
                  style: IjudiStyles.CONTENT_TEXT,
                )),
            Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: FloatingActionButtonWithProgress(
                  viewModel: viewModel.progressMv,
                  onPressed: () {
                    showConfirmCashOrder(context);
                  },
                  child: Icon(Icons.arrow_forward),
                )),
          ],
        );
        break;
    }
    return payment;
  }

  payNowWebView(BuildContext context) {
    var doneAction = (String status) {
      if (status.toLowerCase() == "complete") {
        viewModel.processPayment();
      }
    };
    var args = [
      "${viewModel.paymentUrl}/?Status=init&type=payfast&TransactionReference=${viewModel.order!.id}&callback=https://www.izinga.co.za",
      doneAction
    ];
    Navigator.pushNamed(context, PaymentWebView.ROUTE_NAME, arguments: args);
  }
}
