import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/model/withdrawal.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

mixin MessageDialogs {
  void showMessageDialog(BuildContext context,
      {String title,
      Widget child,
      String actionName,
      Function action,
      Function cancel}) {
    if (cancel == null) cancel = () => {};

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(left: 0, top: 0),
                titlePadding: EdgeInsets.only(left: 16, top: 16),
                buttonPadding: EdgeInsets.only(top: 8, bottom: 16, right: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: Text(title),
                content: child,
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel", style: Forms.INPUT_TEXT_STYLE),
                    onPressed: () {
                      cancel();
                      Navigator.of(context).pop();
                    },
                  ),
                  action is Function
                      ? FlatButton(
                          child:
                              Text(actionName, style: Forms.INPUT_TEXT_STYLE),
                          onPressed: () {
                            Navigator.of(context).pop();
                            action();
                          },
                        )
                      : Container(),
                ],
              );
            },
          );
        });
  }

  void showWebViewDialog(BuildContext context,
      {Widget header, String url, Function doneAction}) {
    print(url);
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              height: Utils.calculationDialogMinHeight(context),
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  header,
                  Expanded(
                      child: WebView(
                          initialUrl: url,
                          onPageFinished: (url) {
                            if (url == "http:/localhost") {}
                          },
                          javascriptMode: JavascriptMode.unrestricted)),
                  Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          doneAction();
                        },
                      ))
                ],
              ),
            ));
      },
    );
  }

  showWithdraw(BuildContext context,
      {@required Bank wallet,
      @required UkhesheService ukhesheService,
      @required BaseViewModel viewModel}) {
    int amount = 0;
    Withdrawal pending;
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    var style = isLight ? IjudiStyles.DIALOG_DARK : IjudiStyles.DIALOG_WHITE;
    var styleBold =
        isLight ? IjudiStyles.DIALOG_DARK_BOLD : IjudiStyles.DIALOG_WHITE_BOLD;
    var importantText = IjudiStyles.DIALOG_IMPORTANT_TEXT;

    if (wallet.availableBalance < 10) {
      viewModel.showError(
          error: "Insufficient Funds. Please topup your wallet");
      return;
    }

    ukhesheService
        .getWithdrawals(wallet.customerId)
        .asStream()
        .asyncExpand((withdrawals) => Stream.fromIterable(withdrawals))
        .where((withdrawal) => withdrawal.status == WithdrawalStatus.PENDING)
        .listen((value) => pending = value, onError: (e) => viewModel.showError(error: e))
        .onDone(() {
      if (pending != null) {
        showMessageDialog(context,
            title: "Pending Withdrawal",
            actionName: "Done",
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset("assets/images/uKhese-logo.png",
                                width: 90),
                            Container(margin: EdgeInsets.only(top: 8)),
                            RichText(
                                strutStyle: StrutStyle.fromTextStyle(style),
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "You have a pending withdrawal of ",
                                      style: style),
                                  TextSpan(
                                    text:
                                        "R${Utils.formatToCurrency(pending.amount)} ",
                                    style: importantText,
                                  ),
                                  TextSpan(
                                      text: "Use the token: ", style: style),
                                  TextSpan(
                                    text: "${pending.token} ",
                                    style: importantText,
                                  ),
                                  TextSpan(
                                      text:
                                          "to withdraw at any *Pick n Pay* store. The token expires on ",
                                      style: style),
                                  TextSpan(
                                      text:
                                          "${DateFormat("dd MMM yy 'at' HH:mm").format(pending.expires)}",
                                      style: styleBold),
                                ]))
                          ]))
                ]));
      } else {
        showMessageDialog(context,
            title: "Cash Withdrawal",
            actionName: "Get Token",
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset("assets/images/uKhese-logo.png",
                              width: 90),
                          Container(margin: EdgeInsets.only(top: 8)),    
                          Text("Please enter your widrawal amount.",
                              style: Forms.INPUT_TEXT_STYLE),
                          Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                              "We will send you a token to withdraw at any Pick n Pay stores",
                              style: Forms.INPUT_TEXT_STYLE),
                        ],
                      )),
                  IjudiInputField(
                    hint: "Amount",
                    autofillHints: [AutofillHints.transactionAmount],
                    type: TextInputType.numberWithOptions(decimal: true),
                    text: "$amount",
                    onChanged: (value) => amount = int.parse(value),
                  ),
                ]), action: () {
          ukhesheService
              .initiateWithdrawal(wallet.customerId, amount.roundToDouble(),
                  DateFormat("SSSmmHHyyddMMss").format(DateTime.now()))
              .asStream()    
              .listen((value) {
            showWithdraw(context,
                wallet: wallet,
                ukhesheService: ukhesheService,
                viewModel: viewModel);
            viewModel.notifyChanged();
          }, onError: (e) => viewModel.showError(error: e));
        });
      }
    });
  }
}
