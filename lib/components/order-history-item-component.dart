import 'package:flutter/material.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:intl/intl.dart';

class OrderHistoryItemComponent extends StatelessWidget {
  
  static const statusColors = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: IjudiColors.color2,
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: IjudiColors.color2,
    OrderStage.STAGE_2_STORE_PROCESSING: IjudiColors.color3,
    OrderStage.STAGE_3_READY_FOR_COLLECTION: IjudiColors.color4,
    OrderStage.STAGE_4_ON_THE_ROAD: IjudiColors.color1,
    OrderStage.STAGE_5_ARRIVED: IjudiColors.color5,
    OrderStage.STAGE_6_WITH_CUSTOMER: IjudiColors.color6,
    OrderStage.STAGE_7_PAID_SHOP: IjudiColors.color4
  };

  static const LOTTIE_BY_STAGE = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "assets/lottie/loading.json",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "assets/lottie/packing.json",
    OrderStage.STAGE_2_STORE_PROCESSING: "assets/lottie/delivery.json",
    OrderStage.STAGE_3_READY_FOR_COLLECTION: "assets/lottie/food.json",
    OrderStage.STAGE_4_ON_THE_ROAD: "assets/lottie/done.json"
  };

  static const statusText = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "Not Paid",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "Waiting Confirmation",
    OrderStage.STAGE_2_STORE_PROCESSING: "Processing",
    OrderStage.STAGE_3_READY_FOR_COLLECTION: "Ready",
    OrderStage.STAGE_4_ON_THE_ROAD: "Arriving",
    OrderStage.STAGE_5_ARRIVED: "Arrived",
    OrderStage.STAGE_6_WITH_CUSTOMER: "Delivered",
    OrderStage.STAGE_7_PAID_SHOP: "Completed"
  };

  final Order order;
  final Function onTap;

  OrderHistoryItemComponent({@required this.order, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(),
        child: Container(
          margin: EdgeInsets.only(left: 0, right: 8, top: 1),
          child: Card(
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
                                Text(
                                    "Ordered On: ${DateFormat("dd MMM yy 'at' HH:mm").format(order.date)}",
                                    style: IjudiStyles.CARD_SHOP_DISCR),
                                Padding(padding: EdgeInsets.only(top: 8)),
                                Text("Total Amount: R${order.totalAmount}")
                              ],
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 90,
                          color: statusColors[order.stage],
                          child: Text(
                            statusText[order.stage],
                            style: IjudiStyles.HEADER_TEXT,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]))),
        ));
  }
}
