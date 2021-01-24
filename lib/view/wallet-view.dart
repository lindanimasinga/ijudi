import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/wallet-card.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/wallet-view-model.dart';

class WalletView extends MvStatefulWidget<WalletViewModel> {
  static const ROUTE_NAME = "wallet-view";

  WalletView({WalletViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    bool complianceChecksAllPassed = viewModel.wallet.status == null ||
        viewModel.wallet.status.complianceChecksAllPassed;
    if (!complianceChecksAllPassed && !viewModel.notFicadShown) {
      Future.delayed(Duration(seconds: 2))
          .then((value) => showFicaMessage(context));
      viewModel.notFicadShown = true;
    }

    return ScrollableParent(
        hasDrawer: true,
        appBarColor: IjudiColors.color3,
        title: "Wallet",
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WalletCard(
                      wallet: viewModel.wallet,
                      onTopUp: () =>
                          viewModel.wallet.status.complianceChecksAllPassed
                              ? _showTopBalanceMessage(context)
                              : showFicaMessage(context),
                      onWithdraw: () => showWithdraw(context,
                          wallet: viewModel.wallet,
                          viewModel: viewModel,
                          ukhesheService: viewModel.ukhesheService)),
                  Container(
                      margin: EdgeInsets.only(top: 48, left: 16, right: 16),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What is Ukheshe",
                            style: IjudiStyles.HEADING,
                          ),
                          Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            viewModel.about,
                            style: IjudiStyles.CONTENT_TEXT,
                          ),
                          Padding(padding: EdgeInsets.only(top: 32)),
                          Text(
                            "How to deposit or withdraw my money",
                            style: IjudiStyles.HEADING,
                          ),
                          Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            viewModel.depositNWithdraw,
                            style: IjudiStyles.CONTENT_TEXT,
                          ),
                          Padding(padding: EdgeInsets.only(top: 32)),
                          Text(
                            "Learn more about Ukheshe",
                            style: IjudiStyles.HEADING,
                          ),
                          Padding(padding: EdgeInsets.only(top: 8)),
                          InkWell(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Click here to find out more ",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue)),
                                TextSpan(
                                    text: "UKHESHE",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue)),
                              ])),
                              onTap: () => Utils.launchURLInCustomeTab(context,
                                  url: viewModel.visitUrl)),
                          Padding(padding: EdgeInsets.only(top: 8)),
                          InkWell(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "UKHESHE Terms and Conditions",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue))
                              ])),
                              onTap: () => Utils.launchURLInCustomeTab(context,
                                  url:
                                      "https://www.ukheshe.co.za/terms-and-conditions")),
                        ],
                      ))
                ],
              ))
        ]));
  }

  _showTopBalanceMessage(BuildContext context) {
    showMessageDialog(context,
        title: "Wallet TopUp",
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
                      Text("Please enter your topup amount.",
                          style: Forms.INPUT_TEXT_STYLE),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text("A fee of 2.5% will be added for card topups",
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
                viewModel.hasCards
                    ? showWebViewDialog(context,
                        header: Image.asset("assets/images/uKhese-logo.png", width: 100),
                        url: "${viewModel.cardlinkingResponse.completionUrl}",
                        doneAction: () {
                          viewModel.fetchPaymentCards().onData((data) {
                            topup(context);
                          });
                        })
                : topup(context);
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
          header: Image.asset("assets/images/uKhese-logo.png", width: 100),
          url: "${topUpData.completionUrl}", 
          doneAction: () {
            viewModel.fetchNewAccountBalances();
            subs.cancel();
          });
    });
  }

}
