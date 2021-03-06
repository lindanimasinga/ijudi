import 'package:flutter/material.dart';
import 'package:ijudi/model/transaction.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:intl/intl.dart';

class TransactionHistoryItemComponent extends StatelessWidget {
  
  final Transaction transaction;
  final statuColors = {
    "DEBIT" : IjudiColors.color2,
    "CREDIT" : IjudiColors.color1,
    "FEE" : IjudiColors.color3,
    "TOPUP" : IjudiColors.color4,
  };

    final statuNames = {
    "DEBIT" : "DEBIT",
    "CREDIT" : "CREDIT",
    "FEE" : "FEE",
    "TOPUP" : "TOPUP"
  };

  TransactionHistoryItemComponent(this.transaction);
  
  @override
  Widget build(BuildContext context) {
     
    var transactionWidget = Container(
        padding: EdgeInsets.only(bottom: 16),
        margin: EdgeInsets.only(right:16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:  EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
              color: statuColors[transaction.type],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(new DateFormat("dd MMM yyyy HH:mm").format(transaction.date.toLocal()), style: IjudiStyles.HEADER_TEXT),
                  Text("${statuNames[transaction.type]}", style: IjudiStyles.HEADER_TEXT)
                ]
              ),
            ),
            Container(
              padding:  EdgeInsets.only(left: 16, top: 16,right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Text("${transaction.description}", style: Forms.INPUT_TEXT_STYLE)
                  ),
                  Text("R${Utils.formatToCurrency(transaction.amount)}", style: Forms.INPUT_TEXT_STYLE)
                ],
              )
            )
          ]
        ),
      );

    return transactionWidget;
  }
}