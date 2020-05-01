import 'package:flutter/material.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/theme-utils.dart';

class StocksComponent extends StatefulWidget {
  final List<Stock> stock;
  final Function addAction;

  StocksComponent({@required this.stock, @required this.addAction});

  @override
  _StocksComponentState createState() => _StocksComponentState(stock, addAction);
}

class _StocksComponentState extends State<StocksComponent> {
  List<Stock> stock;
  Function addAction;

  _StocksComponentState(this.stock, this.addAction);

  @override
  Widget build(BuildContext context) {
    
    if (stock == null)
    return 
        Card(child:Container(
            width: 352,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: IjudiColors.color5, width: 0.05),
            ),
            child: Text("Stock empty"),
          ));

    List<Widget> stockWidget = <Widget>[];
    stock.forEach((item) {
      stockWidget.add(Container(
        width: 352,
        height: 52,
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
              child: Text("R${item.price}", style: Forms.INPUT_TEXT_STYLE,)
            ),
            Container(
              child: FlatButton(
                onPressed: item.itemsAvailable > 0 ? ()=> addAction(item.take(1)) : null, 
                child: Text("ADD")
              ) 
            )
          ],
        ),
      ));
    });

    return Card(child:Column(
      children: stockWidget,
    ));
  }
}
