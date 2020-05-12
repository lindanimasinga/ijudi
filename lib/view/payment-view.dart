import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/ukheshe-payment-compoment.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/payment-view-model.dart';

class PaymentView extends MvStatefulWidget<PaymentViewModel> {
  
  static const String ROUTE_NAME = "payment";

  PaymentView({viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color3,
        title: "Payment",
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Padding(
              padding: EdgeInsets.only(top: 16, left: 0, right: 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text("${viewModel.order.busket.shop.name}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, left: 16),
                        child: Text("Order: ${viewModel.order.id}",
                            style: IjudiStyles.HEADER_TEXT)),
                    OrderComponent(order: viewModel.order),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, top: 16, left: 16),
                        child: Text("Delivery By",
                            style: IjudiStyles.HEADER_TEXT)),
                    MessagerPreviewComponent(
                        messenger: viewModel.order.shippingData.messanger),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, top: 16, left: 16),
                        child: Text("Payment Details",
                            style: Forms.INPUT_TEXT_STYLE)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(bottom: 16),
                            child:
                                UkheshePaymentComponent(viewModel.order.busket.customer)),
                        Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 24),
                        child: FloatingActionButtonWithProgress(
                          viewModel: viewModel.progressMv,
                          onPressed: () {
                            viewModel.processPayment();
                          },
                          child: Icon(Icons.arrow_forward),
                        )),
                      ],
                    )
                  ]))
        ]));
  }
}
