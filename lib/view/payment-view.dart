import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
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
                            if(viewModel.isBalanceLow) {
                              _showLowBalanceMessage(context);
                              return;
                            }
                            viewModel.processPayment();
                          },
                          child: Icon(Icons.arrow_forward),
                        )),
                      ],
                    )
                  ]))
        ]));
  }

  _showLowBalanceMessage(BuildContext context) {
    showMessageDialog(
        context,
        title: "Insufficient Funds",
        actionName: "Topup",
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
              Padding(padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Your order costs R${viewModel.order.totalAmount}", style: Forms.INPUT_TEXT_STYLE),
                    Text("Your Available Balance is R${viewModel.order.busket.customer.bank.availableBalance}", style: Forms.INPUT_TEXT_STYLE),
                    Text(""),
                    Image.asset("assets/images/uKhese-logo.png", width: 90),
                    Text("Please topup to finish your order.", style: Forms.INPUT_TEXT_STYLE),
                  ],
                )
              ),
              IjudiInputField(
                  hint: "Amount",
                  type: TextInputType.numberWithOptions(decimal: true),
                  text: viewModel.topupAmount,
                  onTap: (value) => viewModel.topupAmount = value,
              ),
            ]
          ),
        action: () {
          viewModel.topUp()
            .onData((topUpData) {
              showWebViewDialog(context,
               header: Image.asset("assets/images/uKhese-logo.png", width: 20),
               url: "${viewModel.baseUrl}${topUpData.completionUrl}",
               doneAction: () => viewModel.fetchNewAccountBalances());
            });
        });
  }
}
