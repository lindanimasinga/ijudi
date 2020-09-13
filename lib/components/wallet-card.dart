import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/tranasction-history-view.dart';

class WalletCard extends StatelessWidget with MessageDialogs {
  final Bank wallet;
  final Function onTopUp;
  final Function onWithdraw;

  final String depositMessage = "";

  const WalletCard({@required this.wallet, @required this.onTopUp,  @required this.onWithdraw});

  @override
  Widget build(BuildContext context) {
    var config = Config.currentConfig;
    return IJudiCard(
        child: Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/uKhese-logo.png", width: 100),
                Text("Account. ${wallet.accountId}")
              ],
            ),
            Container(
              alignment: Alignment.topRight,
              child: Text("Phone number. ${wallet.phone}"),
            ),
            Padding(padding: EdgeInsets.only(bottom: 32)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current Balance",
                  style: IjudiStyles.CARD_HEADER,
                ),
                Text("R${Utils.formatToCurrency(wallet.currentBalance)}",
                    style: IjudiStyles.CARD_DISCR_ITAL),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Available Balance", style: IjudiStyles.CARD_HEADER),
                Text("R${Utils.formatToCurrency(wallet.availableBalance)}",
                    style: IjudiStyles.CARD_DISCR_ITAL),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                        iconSize: 32,
                        icon: Icon(Icons.add_circle, color: IjudiColors.color4),
                        onPressed: () => onTopUp()),
                    Text("TopUp", style: IjudiStyles.CARD_ICON_BUTTON)
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
                        onPressed: () => onDeposit(context,
                            nedbankAccount:
                                config.depositingNedBankAccountNumber,
                            fnbAccount: config.depositingFnbBankAccountNumber,
                            ukhesheAccount: wallet.accountId)),
                    Text("Cash Deposit", style: IjudiStyles.CARD_ICON_BUTTON)
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        iconSize: 32,
                        icon: Icon(Icons.money_off, color: IjudiColors.color2),
                        onPressed: () => onWithdraw()),
                    Text("Cash Withdraw", style: IjudiStyles.CARD_ICON_BUTTON)
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        iconSize: 32,
                        icon: Icon(Icons.list, color: IjudiColors.color1),
                        onPressed: () => Navigator.pushNamed(
                            context, TransactionHistoryView.ROUTE_NAME,
                            arguments: wallet)),
                    Text("Transactions", style: IjudiStyles.CARD_ICON_BUTTON)
                  ],
                )
              ],
            ),
          ]),
    ));
  }

  onDeposit(BuildContext context,
      {@required String nedbankAccount,
      @required String fnbAccount,
      @required String ukhesheAccount}) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isLight = brightnessValue == Brightness.light;
    var style = isLight ? IjudiStyles.DIALOG_DARK : IjudiStyles.DIALOG_WHITE;
    var styleBold =
        isLight ? IjudiStyles.DIALOG_DARK_BOLD : IjudiStyles.DIALOG_WHITE_BOLD;
    var importantText = IjudiStyles.DIALOG_IMPORTANT_TEXT;
    showMessageDialog(context,
        child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: RichText(
                strutStyle: StrutStyle.fromTextStyle(style),
                text: TextSpan(children: [
                  TextSpan(text: "Deposit cash at the ", style: style),
                  TextSpan(
                      text: "Nedbank ATM into account number ",
                      style: styleBold),
                  TextSpan(
                    text: "$nedbankAccount",
                    style: importantText,
                  ),
                  TextSpan(
                      text:
                          " or deposit cash at the",
                      style: style),
                  TextSpan(
                      text:
                          " FNB ATM into account number ",
                      style: styleBold),    
                  TextSpan(text: "$fnbAccount", style: importantText),
                  TextSpan(text: ". Use", style: style),
                  TextSpan(text: " $ukhesheAccount", style: importantText),
                  TextSpan(text: " as your reference.", style: styleBold),
                  TextSpan(
                      text:
                          "\n\nMake sure the reference number entered is correct for the funds to reflect immediately on your wallet.",
                      style: style),
                ]))),
        title: "Deposit",
        cancel: () => {});
  }

  
}
