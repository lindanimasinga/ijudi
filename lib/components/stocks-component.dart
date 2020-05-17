import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/stock-view-model.dart';

class StocksComponent extends MvStatefulWidget<StockViewModel> {
  final Function addAction;

  StocksComponent({@required StockViewModel viewModel, @required this.addAction}): super(viewModel);

  @override
  Widget build(BuildContext context) {

    if (viewModel.stock == null)
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
    viewModel.stock.forEach((item) {
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

    return Card(
      child:Column(
      children: stockWidget,
    ));
  }
}
