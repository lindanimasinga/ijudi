import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/wallet-view-model.dart';

class WalletView extends MvStatefulWidget<WalletViewModel> {
  
  static const ROUTE_NAME = "wallet-view";

  
  WalletView({WalletViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: true,
        appBarColor: IjudiColors.color1,
        title: "Wallet",
        child: Stack(
          children: <Widget>[
            Headers.getHeader(context),
            Container(
              margin: EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IJudiCard(
                    child: Container(
                    margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Image.asset("assets/images/uKhese-logo.png", width: 100),
                            Text("Account. ${viewModel.wallet.accountId}")
                          ],),
                          Container(
                            alignment: Alignment.topRight,
                            child: Text("Phone number. ${viewModel.wallet.phone}"),),
                          Padding(padding: EdgeInsets.only(bottom: 32)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Current Balance", style: IjudiStyles.CARD_HEADER,),
                            Text("R${viewModel.wallet.currentBalance}", style: IjudiStyles.CARD_DISCR_ITAL),
                          ],),
                          Padding(padding: EdgeInsets.only(bottom: 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Available Balance", style: IjudiStyles.CARD_HEADER),
                            Text("R${viewModel.wallet.availableBalance}", style: IjudiStyles.CARD_DISCR_ITAL),
                          ],),
                          Padding(padding: EdgeInsets.only(bottom: 16)),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,  
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.add_circle,
                                        color: IjudiColors.color4),
                                    onPressed: () => _showLowBalanceMessage(context)),
                                Text("TopUp",
                                    style: IjudiStyles.CARD_ICON_BUTTON)
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.money_off,
                                        color: IjudiColors.color2),
                                    onPressed: null),
                                Text("Withdraw",
                                    style: IjudiStyles.CARD_ICON_BUTTON)
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    iconSize: 32,
                                    icon: Icon(Icons.monetization_on,
                                        color: IjudiColors.color3),
                                    onPressed: null),
                                Text("Deposit",
                                    style: IjudiStyles.CARD_ICON_BUTTON)
                              ],
                            )
                          ],
                        ),
                        ]),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 48, left: 16, right: 16),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: [
                      Text("What is Ukheshe", style: IjudiStyles.HEADING,),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(viewModel.about, style: IjudiStyles.CONTENT_TEXT,),
                      Padding(padding: EdgeInsets.only(top: 32)),
                      Text("How to deposit or withdraw my money", style: IjudiStyles.HEADING,),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(viewModel.depositNWithdraw, style: IjudiStyles.CONTENT_TEXT,),
                      Padding(padding: EdgeInsets.only(top: 32)),
                      Text("Learn more about Ukheshe", style: IjudiStyles.HEADING,),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      InkWell(
                        child: RichText (
                          text:TextSpan(
                            children: [
                              TextSpan(text: "Click here to find out more ", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                              TextSpan( text: "UKHESHE", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                            ]
                          )
                        ),
                        onTap: () => showWebViewDialog(
                            context,
                            url: viewModel.visitUrl,
                            doneAction: () => viewModel.fetchNewAccountBalances()
                            ) 
                      )
                    ],
                  )
                  )
                   
                ],
              )
            )
          ]
        )
    );
  }

  _showLowBalanceMessage(BuildContext context) {
    showMessageDialog(
        context,
        title: "Account TopTup",
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
                    Image.asset("assets/images/uKhese-logo.png", width: 90),
                    Text("Please enter your topup amount.", style: Forms.INPUT_TEXT_STYLE),
                  ],
                )
              ),
              IjudiInputField(
                  hint: "Amount",
                  autofillHints: [AutofillHints.transactionAmount],
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