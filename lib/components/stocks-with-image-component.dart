import 'package:flutter/material.dart';
import 'package:ijudi/components/stock-item-component.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/theme-utils.dart';

class StocksWithImageComponent extends StatelessWidget {
  final Function addAction;
  final List<Stock> stocks;
  final String label;

  StocksWithImageComponent({@required this.label, @required this.stocks, @required this.addAction});

  @override
  Widget build(BuildContext context) {
    if (stocks == null || stocks.isEmpty)
      return Card(
          margin: EdgeInsets.only(left: 0),
          child: Container(
            height: 62,
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: IjudiColors.color5, width: 0.05),
            ),
            child: Text("Stock empty"),
          ));

    List<Widget> stockWidget = <Widget>[];
    stocks.forEach((item) {
      stockWidget.add(StockItemComponent(item: item, addAction: addAction));
    });

    return Column(children: [
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Text(label , style: IjudiStyles.SUBTITLE_2)),
      Card(
          child: Column(
        children: stockWidget,
      ))
    ]);
  }
}
