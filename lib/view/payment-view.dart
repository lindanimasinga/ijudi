import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/ijudi-time-input-field.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-review-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/ukheshe-payment-compoment.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
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
              padding: EdgeInsets.only(top: 16, left: 0, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text("${viewModel.order.shop.name}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, left: 16),
                        child: Text("Order: ${viewModel.order.id}",
                            style: IjudiStyles.HEADER_TEXT)),
                    OrderReviewComponent(order: viewModel.order),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 16, top: 16, left: 16),
                        child: Text(viewModel.deliveryHeader,
                            style: IjudiStyles.HEADER_TEXT)),
                    viewModel.isDelivery
                        ? MessagerPreviewComponent(
                            messenger: viewModel.order.shippingData.messenger)
                        : Container(
                            alignment: Alignment.topLeft,
                            child: IjudiForm(
                                child: IjudiTimeInput(
                                    hint: "Pick Up Time",
                                    enabled: false,
                                    text:
                                        "${Utils.pickUpDay(viewModel.order.shippingData.pickUpTime, context)}"))),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, top: 16, left: 16),
                        child: Text("Payment Details",
                            style: Forms.INPUT_TEXT_STYLE)),
                    paymentSelectorOptionsWidget(context),
                    paymentWidget(context)
                  ]))
        ]));
  }

  _showLowBalanceMessage(BuildContext context) {
    showMessageDialog(context,
        title: "Insufficient Funds",
        actionName: "Topup",
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("A fee of 2.5% will be added for card topups",
                          style: Forms.INPUT_TEXT_STYLE),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("Your order costs R${viewModel.order.totalAmount}",
                          style: Forms.INPUT_TEXT_STYLE),
                      Text(
                          "Your Available Balance is R${viewModel.order.customer.bank.availableBalance}",
                          style: Forms.INPUT_TEXT_STYLE),
                      Text(""),
                      Image.asset("assets/images/uKhese-logo.png", width: 70),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("Please topup to finish your order.",
                          style: Forms.INPUT_TEXT_STYLE),
                    ],
                  )),
              IjudiInputField(
                hint: "Amount",
                autofillHints: [AutofillHints.transactionAmount],
                type: TextInputType.numberWithOptions(decimal: true),
                text: viewModel.topupAmount,
                onChanged: (value) => viewModel.topupAmount = value,
              ),
            ]), action: () {
      !viewModel.hasCards
          ? loadNewCardWebView(context, () {
              viewModel.fetchPaymentCards().onData((data) {
                selectCard(context);
              });
            })
          : selectCard(context);
    });
  }

  topup(BuildContext context) {
    viewModel.topUp().onData((topUpData) {
      //check payment successful
      var subs =
          viewModel.checkTopUpSuccessul(topUpId: topUpData.topUpId, delay: 60);
      subs.onDone(() {
        Navigator.of(context).pop();
        viewModel.fetchNewAccountBalances();
      });
      showWebViewDialog(context,
          header: Image.asset("assets/images/uKhese-logo.png", width: 80),
          url: "${topUpData.completionUrl}", doneAction: () {
        viewModel.fetchNewAccountBalances();
        subs.cancel();
      });
    });
  }

  showConfirmPayment(BuildContext context) {
    showMessageDialog(context,
        title: "Confirm Payment",
        actionName: "Pay",
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                "Please click pay to confirm your order of R${viewModel.order.totalAmount}",
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
                "Please proceed to confirm your order of cash payment amount R${viewModel.order.totalAmount}.",
                style: Forms.INPUT_TEXT_STYLE)),
        action: () => viewModel.processCashPayment());
  }

  Widget paymentSelectorOptionsWidget(BuildContext context) {
    var options = Container(
        alignment: Alignment.topLeft,
        child: IjudiForm(
            child: Row(
          children: <Widget>[
            Radio(
              value: PaymentType.UKHESHE,
              groupValue: viewModel.paymentType,
              onChanged: (selection) => viewModel.paymentType = selection,
            ),
            Image.asset("assets/images/uKhese-logo.png", width: 70),
            /* Radio(
              value: PaymentType.CASH,
              groupValue: viewModel.paymentType,
              onChanged: (selection) => viewModel.paymentType = selection,
            ),
            Text('Cash', style: Forms.INPUT_TEXT_STYLE)*/
          ],
        )));
    return options;
  }

  Widget paymentWidget(BuildContext context) {
    var payment;
    double deviceWidth = MediaQuery.of(context).size.width;
    double paybuttonPadding = deviceWidth >= 360 ? 16 : 8;

    switch (viewModel.paymentType) {
      case PaymentType.UKHESHE:
        payment = Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 16),
                child: UkheshePaymentComponent(viewModel.order.customer)),
            Padding(
                padding: EdgeInsets.only(left: paybuttonPadding, bottom: 24),
                child: FloatingActionButtonWithProgress(
                  viewModel: viewModel.progressMv,
                  onPressed: () {
                    viewModel.paymentSuccessful
                        ? viewModel.processPayment()
                        : !viewModel.isBalanceLow
                            ? showConfirmPayment(context)
                            : !viewModel.wallet.status.complianceChecksAllPassed
                                ? showFicaMessage(context)
                                : _showLowBalanceMessage(context);
                    return;
                  },
                  child: Icon(Icons.arrow_forward),
                )),
          ],
        );
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
                    if (viewModel.isBalanceLow) {
                      _showLowBalanceMessage(context);
                      return;
                    }
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

  selectCard(BuildContext context) {
    List<Widget> cardsWidget = viewModel.paymentCards
        .map<Widget>((card) => Container(
            margin: EdgeInsets.only(bottom: 0.45),
            child: ListTile(
              title: Text(card.alias),
              leading: Icon(Icons.credit_card_rounded,
                  size: 32, color: IjudiColors.color3),
              subtitle: Text("Card Num:    ***${card.last4Digits}"),
              onTap: () => viewModel.paymentCardselected = card,
            )))
        .toList();
    cardsWidget.add(ListTile(
        title: Text("[ADD NEW CARD]"),
        leading: Icon(Icons.credit_card, size: 32, color: IjudiColors.color4),
        subtitle: Text("Top-up using a new card"),
        onTap: () {
          Navigator.of(context).pop();
          loadNewCardWebView(
              context, () => viewModel.fetchPaymentCards().onData((data) {}));
        }));
    cardsWidget.add(ListTile(
        title: Text("[DELETE ALL CARDS]"),
        leading: Icon(Icons.delete, size: 32, color: IjudiColors.color2),
        subtitle: Text("Delete All Cards Linked"),
        onTap: () {
          Navigator.of(context).pop();
          viewModel.deleteAllLinkedCards();
        }));

    return showMessageDialog(context,
        title: "Select Card",
        actionName: "Continue",
        child: Container(
            margin: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.height * 0.25,
            height: MediaQuery.of(context).size.height * 0.30,
            child: ListView(children: cardsWidget)),
        action: () => topup(context));
  }

  loadNewCardWebView(BuildContext context, Function onDone) {
    showWebViewDialog(context,
        header: Image.asset("assets/images/uKhese-logo.png", width: 80),
        url: "${viewModel.cardlinkingResponse.completionUrl}",
        doneAction: () => onDone());
  }
}
