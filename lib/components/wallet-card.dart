import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/tranasction-history-view.dart';

class WalletCard extends StatelessWidget {
  final Bank wallet;
  final Function onTopUp;

  const WalletCard({@required this.wallet, this.onTopUp});

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () => onTopUp()
                    ),
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
                        onPressed: null),
                    Text("Deposit", style: IjudiStyles.CARD_ICON_BUTTON)
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        iconSize: 32,
                        icon: Icon(Icons.money_off, color: IjudiColors.color2),
                        onPressed: null),
                    Text("Withdraw", style: IjudiStyles.CARD_ICON_BUTTON)
                  ],
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        iconSize: 32,
                        icon: Icon(Icons.list,
                            color: IjudiColors.color1),
                        onPressed: () => Navigator.pushNamed(context, TransactionHistoryView.ROUTE_NAME, arguments: wallet)),
                    Text("Transactions", style: IjudiStyles.CARD_ICON_BUTTON)
                  ],
                )
              ],
            ),
          ]),
    ));
  }
}
