import 'package:flutter/material.dart';
import 'package:ijudi/model/basket-item.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class BasketComponent extends StatelessWidget {
  final Basket? basket;
  final Function(BasketItem)? removeAction;

  BasketComponent({required this.basket, this.removeAction});

  @override
  Widget build(BuildContext context) {
    if (basket == null || basket!.items.isEmpty)
      return Card(
          margin: EdgeInsets.only(left: 0),
          elevation: 0,
          child: Container(
            height: 52,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Text("Basket empty", style: Forms.INPUT_TEXT_STYLE),
          ));

    List<Widget> basketWidget = <Widget>[];
    basket!.items.forEach((item) {
      basketWidget.add(Container(
        height: 52,
        padding: EdgeInsets.only(left: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                width: 145,
                child: Text(
                  "${item.quantity}  x  ${item.name}",
                  style: Forms.INPUT_TEXT_STYLE,
                )),
            Container(
                child: Text(
              "R${(Utils.formatToCurrency(item.price * item.quantity!))}",
              style: Forms.INPUT_TEXT_STYLE,
            )),
            Container(
                child: FlatButton(
                    onPressed:
                        removeAction == null ? null : () => removeAction!(item),
                    child: removeAction == null ? Text("") : Text("REMOVE")))
          ],
        ),
      ));
    });

    basketWidget.add(Container(
      height: 52,
      padding: EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
        color: IjudiColors.color2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              width: 145,
              child: Text(
                "Total",
                style: IjudiStyles.BREAD_CRUMB,
              )),
          Container(
              width: 60,
              child: Text(
                "R${Utils.formatToCurrency(basket!.getBasketTotalAmount())}",
                style: IjudiStyles.BREAD_CRUMB,
              )),
          Container(
              width: 70,
              child: Text(
                "${(basket!.getBasketTotalItems())} item(s)",
                style: IjudiStyles.BREAD_CRUMB,
              )),
        ],
      ),
    ));

    return Card(
        margin: EdgeInsets.only(left: 0),
        elevation: 0,
        child: Column(
          children: basketWidget,
        ));
  }
}
