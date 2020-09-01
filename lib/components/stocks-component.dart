import 'package:flutter/material.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class StocksComponent extends StatelessWidget {
  
  final Function action;
  final List<Stock> stocks;
  final String actionName;
  final bool enabledAction;

  StocksComponent({@required this.stocks, @required this.action, this.actionName, this.enabledAction = true});

  @override
  Widget build(BuildContext context) {

    if (stocks == null || stocks.isEmpty)
    return 
        Card(
          margin: EdgeInsets.only(left: 0),
          child:Container(
            height: 52,
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
      stockWidget.add(Container(
        height: 52,
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 145,
              child: Text("${item.itemsAvailable}  x  ${item.name}",
                          style: Forms.INPUT_TEXT_STYLE,)
            ),
            Container(
              child: Text("R${Utils.formatToCurrency(item.price)}", style: Forms.INPUT_TEXT_STYLE,)
            ),
            Container(
              child: FlatButton(
                onPressed: enabledAction ? ()=> action(item.take(1)) : null, 
                child: Text(actionName)
              ) 
            )
          ],
        ),
      ));
    });

    return Card(
      margin: EdgeInsets.only(left: 0),
      child:Column(
      children: stockWidget,
    ));
  }
}
