import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/components/wallet-card.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/wallet-view-model.dart';

class WalletView extends MvStatefulWidget<WalletViewModel> {
  
  static const ROUTE_NAME = "wallet-view";

  
  WalletView({WalletViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: true,
        appBarColor: IjudiColors.color3,
        title: "Wallet",
        child: Stack(
          children: <Widget>[
            Headers.getShopHeader(context),
            Container(
              margin: EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WalletCard(
                    wallet: viewModel.wallet,
                    onTopUp: () => _showLowBalanceMessage(context)),
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
              _launchURL(context);
              /*showWebViewDialog(context,
               header: Image.asset("assets/images/uKhese-logo.png", width: 20),
               url: "${viewModel.baseUrl}${topUpData.completionUrl}",
               doneAction: () => viewModel.fetchNewAccountBalances());*/
            });
        });
  }

    void _launchURL(BuildContext context) async {
    try {
      await launch(
        'https://passwords.google.com/',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],        
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

}