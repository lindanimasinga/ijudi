import 'package:flutter/material.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class BasketViewOnlyComponent extends StatefulWidget {

  final Basket? basket;
  final Function(BasketItem)? removeAction;

  BasketViewOnlyComponent({required this.basket, this.removeAction});

  @override
  _BasketViewOnlyComponentState createState() => _BasketViewOnlyComponentState(basket, this.removeAction);
}

class _BasketViewOnlyComponentState extends State<BasketViewOnlyComponent> {
  Basket? basket;
  Function(BasketItem)? removeAction;

  _BasketViewOnlyComponentState(this.basket, this.removeAction);

  @override
  Widget build(BuildContext context) {
  if (basket == null || basket!.items.isEmpty)
    return Card(
            child:Container(
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: IjudiColors.color5, width: 0.05),
              ),
              child: Text("Basket empty", style: Forms.INPUT_TEXT_STYLE),
          ));

    List<Widget> basketWidget = <Widget>[];
    basket!.items.forEach((item) {
      basketWidget.add(
        Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
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
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${item.quantity}  x  ${item.name}",
                        style: IjudiStyles.ITEM,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.options == null
                            ? []
                            : item.options!
                                .map((choice) =>
                                    choice.selected != "None" ?
                                    Text("${choice.name}:  ${choice.selected}", style: IjudiStyles.ITEM_INCLUDED,) :
                                    Text("${choice.name}:  ${choice.selected}", style: IjudiStyles.ITEM_EXCLUDED))
                                .toList(),
                      )
                    ])
            ),
            Container(
              width: 70,
              child: Text("R${(Utils.formatToCurrency(item.price * item.quantity!))}", style: Forms.INPUT_TEXT_STYLE,)
            )
          ],
        ),
      ));
    });

basketWidget.add(Container(
        height: 52,
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: IjudiColors.color5,
          border: Border.all(color: IjudiColors.color5, width: 0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left:0),
              width: 145,
              child: Text("Total", style: IjudiStyles.HEADER_TEXT,)
            ),
            Container(
              width: 70,
              child: Text("R${Utils.formatToCurrency(basket!.getBasketTotalAmount())}", style: IjudiStyles.HEADER_TEXT,)
            ),
          ],
        ),
      ));

    return Card(
      margin: EdgeInsets.only(left: 0),
      child:Column(
      children: basketWidget,
    ));
  }
}