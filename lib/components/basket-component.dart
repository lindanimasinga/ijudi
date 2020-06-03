import 'package:flutter/material.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/util/theme-utils.dart';

class BasketComponent extends StatelessWidget {

  final Basket basket;
  final Function(BasketItem) removeAction;

  BasketComponent({@required this.basket, this.removeAction});

  @override
  Widget build(BuildContext context) {
  if (basket == null || basket.items.isEmpty)
    return Card(
            margin: EdgeInsets.only(left: 0),
            child: Container(
              height: 52,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: IjudiColors.color5, width: 0.25),
              ),
              child: Text("Basket empty", style: Forms.INPUT_TEXT_STYLE),
          ));

    List<Widget> basketWidget = <Widget>[];
    basket.items.forEach((item) {
      basketWidget.add(Container(
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

basketWidget.add(Container(
        height: 52,
        padding: EdgeInsets.only(left: 16),
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
              child: Text("${(basket.getBasketTotalItems())} items", style: IjudiStyles.HEADER_TEXT,)
            ),
            Container(
              width: 70,
              child: Text("R${(basket.getBasketTotalAmount())}", style: IjudiStyles.HEADER_TEXT,)
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