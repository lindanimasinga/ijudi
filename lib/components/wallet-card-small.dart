import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/tranasction-history-view.dart';

class WalletCardSmall extends StatelessWidget with MessageDialogs {
  final Bank wallet;
  final Function onTopUp;
  final Function onWithdraw;

  final String depositMessage = "";

  const WalletCardSmall(
      {required this.wallet,
      required this.onTopUp,
      required this.onWithdraw});

  @override
  Widget build(BuildContext context) {
    var config = Config.currentConfig;
    return IJudiCard(
        child: Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/uKhese-logo.png", width: 80),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text("Account. ${wallet.accountId}"),
                Text("Phone number. ${wallet.phone}")
              ],
            ),
            Column(
              children: [
                Text("Available"),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text("R${Utils.formatToCurrency(wallet.availableBalance)}",
                    style: IjudiStyles.CARD_AMOUNT_DISCR),
              ],
            )
          ]),
    ));
  }

  onDeposit(BuildContext context,
      {required String nedbankAccount,
      required String fnbAccount,
      required String ukhesheAccount}) {
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
                  TextSpan(text: " or deposit cash at the", style: style),
                  TextSpan(
                      text: " FNB ATM into account number ", style: styleBold),
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
