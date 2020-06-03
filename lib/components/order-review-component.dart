import 'package:flutter/material.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';

class OrderReviewComponent extends StatelessWidget {
  final Order order;

  const OrderReviewComponent({this.order});

  @override
  Widget build(BuildContext context) {
    List<Widget> basketWidget = <Widget>[];
    order.basket.items.forEach((item) {
      basketWidget.add(Container(
        height: 52,
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 16),
                width: 145,
                child: Text(
                  "${item.quantity}  x  ${item.name}",
                  style: Forms.INPUT_TEXT_STYLE,
                )),
            Container(
                width: 70,
                child: Text(
                  "R${(item.price * item.quantity)}",
                  style: Forms.INPUT_TEXT_STYLE,
                ))
          ],
        ),
      ));
    });

    basketWidget.add(Container(
      height: 52,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: IjudiColors.color5, width: 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 16),
              width: 145,
              child: Text(
                "Delivery Fee",
                style: Forms.INPUT_TEXT_STYLE,
              )),
          Container(
              width: 70,
              child: Text(
                "R${order.shippingData.fee}",
                style: Forms.INPUT_TEXT_STYLE,
              ))
        ],
      ),
    ));

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
              margin: EdgeInsets.only(left: 16),
              width: 145,
              child: Text(
                order.hasVat? "Total(incl VAT)": "Total(excl VAT)",
                style: IjudiStyles.HEADER_TEXT,
              )),
          Container(
              width: 70,
              child: Text(
                "R${(order.totalAmount)}",
                style: IjudiStyles.HEADER_TEXT,
              )),
        ],
      ),
    ));

    return Card(
        margin: EdgeInsets.only(left: 0),
        child: Column(
          children: basketWidget,
        ));
  }
}
