import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/wallet-card.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/quick-pay-view-model.dart';

class QuickPayView extends MvStatefulWidget<QuickPayViewModel> {
  static const String ROUTE_NAME = "quick-pay";

  QuickPayView({QuickPayViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        title: "Pay In Store",
        appBarColor: IjudiColors.color1,
        child: Stack(children: <Widget>[
          Headers.getHeader(context),
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 16)),
              WalletCard(
                wallet: viewModel.wallet,
                onTopUp: () => _showLowBalanceMessage(context)),
              Container(
                  margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(viewModel.shop.name,
                                style: IjudiStyles.CARD_SHOP_HEADER),
                            Text("${viewModel.shop.role}",
                                style: IjudiStyles.CARD_SHOP_DISCR),
                            Text("Account: ${viewModel.shop.bank.accountId}",
                                style: IjudiStyles.CARD_SHOP_DISCR),
                            Text("Phone: ${viewModel.shop.mobileNumber}",
                                style: IjudiStyles.CARD_SHOP_DISCR)
                          ]),
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(61),
                            color: Colors.white,
                            border: Border.all(
                              color: IjudiColors.color3,
                              width: 3,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(viewModel.shop.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ],
                  )),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 16, left: 16, bottom: 8),
                  child: Text("Payment Details", style: IjudiStyles.CARD_HEADER)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: IjudiForm(
                      child: Column(
                    children: <Widget>[
                      IjudiInputField(
                        hint: "Item Name",
                        autofillHints: [AutofillHints.name],
                        text: viewModel.itemName,
                        onTap: (value) => viewModel.itemName = value,
                      ),
                      IjudiInputField(
                        hint: "Amount",
                        autofillHints: [AutofillHints.transactionAmount],
                        text: "${viewModel.payAmount}",
                        type: TextInputType.text,
                        onTap: (value) => viewModel.payAmount = double.parse(value),
                      ),
                      IjudiInputField(
                        hint: "Quantity",
                        autofillHints: [AutofillHints.name],
                        text: "${viewModel.quantity}",
                        onTap: (value) => viewModel.quantity = int.parse(value),
                      )
                    ],
                  ))),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
              child: FloatingActionButtonWithProgress(
                  onPressed: () {
                    if (viewModel.isBalanceLow) {
                      _showLowBalanceMessage(context);
                      return;
                    }
                    showConfirmPayment(context);
                  },
                  child: Icon(Icons.check),
                  viewModel: viewModel.progressMv))
            ],
          )
        ]));
  }


    _showLowBalanceMessage(BuildContext context) {
    showMessageDialog(context,
        title: "Account TopUp",
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
                    Image.asset("assets/images/uKhese-logo.png", width: 90),
                    Text("Please enter your topup amount.", style: Forms.INPUT_TEXT_STYLE),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    Text("A fee of 2% will be added for card topups", style: Forms.INPUT_TEXT_STYLE),
                  ],
                )),
              IjudiInputField(
                hint: "Amount",
                autofillHints: [AutofillHints.transactionAmount],
                type: TextInputType.text,
                text: "${viewModel.topupAmount}",
                onTap: (value) => viewModel.topupAmount = value,
              ),
            ]), action: () {
      viewModel.topUp().onData((topUpData) {
        showWebViewDialog(context,
            header: Image.asset("assets/images/uKhese-logo.png", width: 20),
            url: "${viewModel.baseUrl}${topUpData.completionUrl}",
            doneAction: () => viewModel.fetchNewAccountBalances());
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
        action: () => viewModel.pay());
  }
}
