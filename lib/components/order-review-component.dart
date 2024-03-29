import 'package:flutter/material.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';

class OrderReviewComponent extends StatelessWidget {
  final Order? order;
  final includeFees;
  final isCustomerView;

  const OrderReviewComponent(
      {this.order, this.includeFees = true, this.isCustomerView = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> basketWidget = <Widget>[];
    order!.basket!.items.forEach((item) {
      basketWidget.add(Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 0),
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
                                .map((choice) => choice.selected != "None"
                                    ? Text(
                                        "${choice.name}:  ${choice.selected}",
                                        style: IjudiStyles.ITEM_INCLUDED,
                                      )
                                    : Text(
                                        "${choice.name}:  ${choice.selected}",
                                        style: IjudiStyles.ITEM_EXCLUDED))
                                .toList(),
                      )
                    ])),
            Container(
                width: 70,
                child: Text(
                  this.isCustomerView || item.storePrice == null
                      ? "R${Utils.formatToCurrency(item.price * item.quantity!)}"
                      : "R${Utils.formatToCurrency(item.storePrice * item.quantity!)}",
                  style: Forms.INPUT_TEXT_STYLE,
                ))
          ],
        ),
      ));
    });

    if (includeFees) {
      basketWidget.add(Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 0),
                width: 145,
                child: Text(
                  "Service Fee",
                  style: Forms.INPUT_TEXT_STYLE,
                )),
            Container(
                width: 70,
                child: Text(
                  "R${Utils.formatToCurrency(order!.serviceFee)}",
                  style: Forms.INPUT_TEXT_STYLE,
                ))
          ],
        ),
      ));
    }

    if (includeFees && order!.shippingFee > 0) {
      basketWidget.add(Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: IjudiColors.color5, width: 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 0),
                width: 145,
                child: Text(
                  "Delivery Fee (${order!.shippingData!.distance}km)",
                  style: Forms.INPUT_TEXT_STYLE,
                )),
            Container(
                width: 70,
                child: Text(
                  "R${Utils.formatToCurrency(order!.shippingData!.fee)}",
                  style: Forms.INPUT_TEXT_STYLE,
                ))
          ],
        ),
      ));
    }

    basketWidget.add(Container(
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
      decoration: BoxDecoration(
        color: IjudiColors.color5,
        border: Border.all(color: IjudiColors.color5, width: 0.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 0),
              width: 145,
              child: Text(
                order!.hasVat! ? "Total(incl VAT)" : "Total(excl VAT)",
                style: IjudiStyles.HEADER_TEXT,
              )),
          Container(
              width: 70,
              child: Text(
                includeFees
                    ? "R${Utils.formatToCurrency(order!.totalAmount)}"
                    : isCustomerView ||
                            order!.basket!.items.first.storePrice == null
                        ? "R${Utils.formatToCurrency(order!.basket!.getBasketTotalAmount())}"
                        : "R${Utils.formatToCurrency(order!.basket!.getBasketStorePriceTotalAmount())}",
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
