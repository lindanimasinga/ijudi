import 'package:flutter/material.dart';
import 'package:ijudi/model/transaction.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:intl/intl.dart';

class TransactionHistoryItemComponent extends StatelessWidget {
  
  final Transaction transaction;
  final statuColors = {
    "TRANSFER_DB" : IjudiColors.color2,
    "TRANSFER_CR" : IjudiColors.color4
  };

    final statuNames = {
    "TRANSFER_DB" : "DEBIT",
    "TRANSFER_CR" : "CREDIT"
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
                  Text(new DateFormat("dd MMM yyyy HH:mm").format(transaction.date), style: IjudiStyles.HEADER_TEXT),
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
                  Text("R${transaction.amount}", style: Forms.INPUT_TEXT_STYLE)
                ],
              )
            )
          ]
        ),
      );

    return transactionWidget;
  }
}