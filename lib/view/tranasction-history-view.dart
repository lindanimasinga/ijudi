import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/transaction-history-item-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/transaction-history-view-model.dart';

class TransactionHistoryView
    extends MvStatefulWidget<TransactionHistoryViewModel> {
  static const ROUTE_NAME = "transaction-history";

  TransactionHistoryView({TransactionHistoryViewModel viewModel})
      : super(viewModel);

  @override
  Widget build(BuildContext context) {
    List<Widget> transationItemsComponents = [];
    transationItemsComponents.add(Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Forms.searchField(context,
            hint: "Search by order number, phone number",
            onChanged: (value) => viewModel.filter = value)));
    viewModel.filteredTransactions.forEach((trn) =>
        transationItemsComponents.add(TransactionHistoryItemComponent(trn)));

    return ScrollableParent(
        title: "Transaction History",
        appBarColor: IjudiColors.color3,
        hasDrawer: false,
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: Column(
              children: transationItemsComponents,
            ),
          )
        ]));
  }
}
