import 'package:flutter/material.dart';
import 'package:ijudi/model/busket-item.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/util/theme-utils.dart';

class BusketComponent extends StatefulWidget {

  final Busket busket;
  final Function(BusketItem) removeAction;

  BusketComponent({@required this.busket, this.removeAction});

  @override
  _BusketComponentState createState() => _BusketComponentState(busket, this.removeAction);
}

class _BusketComponentState extends State<BusketComponent> {
  Busket busket;
  Function(BusketItem) removeAction;

  _BusketComponentState(this.busket, this.removeAction);

  @override
  Widget build(BuildContext context) {
  if (busket == null || busket.items.isEmpty)
    return Card(child:Container(
            width: 352,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: IjudiColors.color5, width: 0.25),
            ),
            child: Text("Busket empty", style: Forms.INPUT_TEXT_STYLE),
          ));

    List<Widget> busketWidget = <Widget>[];
    busket.items.forEach((item) {
      busketWidget.add(Container(
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
              child: Text("${item.quantity}  x  ${item.name}", style: Forms.INPUT_TEXT_STYLE,)
            ),
            Container(
              child: Text("R${(item.price * item.quantity)}", style: Forms.INPUT_TEXT_STYLE,)
            ),
            Container(
              child: FlatButton(
                onPressed: removeAction == null ? null : ()=> removeAction(item), 
                child: removeAction == null ? null : Text("REMOVE")
              ) 
            )
          ],
        ),
      ));
    });

busketWidget.add(Container(
        width: 352,
        height: 52,
        decoration: BoxDecoration(
          color: IjudiColors.color2,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 145,
              child: Text("Total", style: IjudiStyles.HEADER_TEXT,)
            ),
            Container(
              width: 60,
              child: Text("${(busket.getBusketTotalItems())} items", style: IjudiStyles.HEADER_TEXT,)
            ),
            Container(
              width: 70,
              child: Text("R${(busket.getBusketTotalAmount())}", style: IjudiStyles.HEADER_TEXT,)
            ),
          ],
        ),
      ));

    return Card(child:Column(
      children: busketWidget,
    ));
  }
}