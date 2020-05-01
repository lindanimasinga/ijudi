import 'package:flutter/material.dart';
import 'package:ijudi/model/busket-item.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/util/theme-utils.dart';

class BusketViewOnlyComponent extends StatefulWidget {

  final Busket busket;
  final Function(BusketItem) removeAction;

  BusketViewOnlyComponent({@required this.busket, this.removeAction});

  @override
  _BusketViewOnlyComponentState createState() => _BusketViewOnlyComponentState(busket, this.removeAction);
}

class _BusketViewOnlyComponentState extends State<BusketViewOnlyComponent> {
  Busket busket;
  Function(BusketItem) removeAction;

  _BusketViewOnlyComponentState(this.busket, this.removeAction);

  @override
  Widget build(BuildContext context) {
  if (busket == null || busket.items.isEmpty)
    return Card(child:Container(
            width: 352,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: IjudiColors.color5, width: 0.05),
            ),
            child: Text("Busket empty", style: Forms.INPUT_TEXT_STYLE),
          ));

    List<Widget> busketWidget = <Widget>[];
    busket.items.forEach((item) {
      busketWidget.add(
        Container(
        width: 352,
        height: 52,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left:16),
              width: 145,
              child: Text("${item.quantity}  x  ${item.name}", style: Forms.INPUT_TEXT_STYLE,)
            ),
            Container(
              width: 70,
              child: Text("R${(item.price * item.quantity)}", style: Forms.INPUT_TEXT_STYLE,)
            )
          ],
        ),
      ));
    });

busketWidget.add(Container(
        width: 352,
        height: 52,
        decoration: BoxDecoration(
          color: IjudiColors.color5,
          border: Border.all(color: IjudiColors.color5, width: 0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left:16),
              width: 145,
              child: Text("Total", style: IjudiStyles.HEADER_TEXT,)
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