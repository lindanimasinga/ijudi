import 'package:flutter/material.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:intl/intl.dart';

class OrderHistoryItemComponent extends StatelessWidget {
  final Order order;
  final Function onTap;

  OrderHistoryItemComponent({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double statusWidth = deviceWidth >= 360 ? 100 : 71;

    return GestureDetector(
        onTap: () => onTap(),
        child: Container(
          margin: EdgeInsets.only(left: 0, right: 8, top: 1),
          child: Card(
              elevation: 0,
              margin: EdgeInsets.only(left: 0),
              child: Container(
                  color: Theme.of(context).cardColor,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Order Number: ${order.id}",
                                    style: IjudiStyles.CARD_SHOP_DISCR),
                                Padding(padding: EdgeInsets.only(top: 8)),
                                order.shippingData?.type ==
                                        ShippingType.DELIVERY
                                    ? Text(
                                        "Ordered On: ${DateFormat("dd MMM yy 'at' HH:mm").format(order.date!)}",
                                        style: IjudiStyles.CARD_SHOP_DISCR)
                                    : order.shippingData?.type ==
                                            ShippingType.SCHEDULED_DELIVERY
                                        ? Text(
                                            "Delivery On: ${DateFormat("dd MMM yy 'at' HH:mm").format(order.shippingData!.pickUpTime!)}",
                                            style: IjudiStyles.CARD_SHOP_DISCR)
                                        : Text(
                                            "In store: ${DateFormat("dd MMM yy 'at' HH:mm").format(order.date!)}",
                                            style: IjudiStyles.CARD_SHOP_DISCR),
                                Padding(padding: EdgeInsets.only(top: 8)),
                                Text(
                                    "Total Amount: R${Utils.formatToCurrency(order.basket!.getBasketTotalAmount())}")
                              ],
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: statusWidth,
                          height: 90,
                          color: Utils.orderStatusColors[order.stage!],
                          child: Text(
                            Utils.statusText[order.stage!]!,
                            style: IjudiStyles.HEADER_TEXT,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]))),
        ));
  }
}
