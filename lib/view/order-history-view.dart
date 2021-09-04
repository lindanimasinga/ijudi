import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-history-item-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/viewmodel/order-history-view-model.dart';

import 'quick-payment-success.dart';

class OrderHistoryView extends MvStatefulWidget<OrderHistoryViewModel> {
  static const ROUTE_NAME = "order-history";

  OrderHistoryView({required OrderHistoryViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    List<Widget> pendingOrderItemsComponents = [
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Current Orders", style: IjudiStyles.HEADER_2_WHITE)),
    ];
    List<Widget> finishedOrderItemsComponents = [
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Past Orders", style: IjudiStyles.HEADER_2)),
    ];

    viewModel.orders
        .where((order) => order.stage != OrderStage.STAGE_7_ALL_PAID)
        .where((order) => order.orderType != OrderType.INSTORE)
        .forEach((order) =>
            pendingOrderItemsComponents.add(OrderHistoryItemComponent(
                order: order,
                onTap: () {
                  if (order.orderType == OrderType.ONLINE) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        FinalOrderView.ROUTE_NAME,
                        (Route<dynamic> route) => false,
                        arguments: order);
                  } else {
                    Navigator.pushNamed(context, ReceiptView.ROUTE_NAME,
                        arguments: order);
                  }
                })));

    viewModel.orders
        .where((order) => order.stage == OrderStage.STAGE_7_ALL_PAID)
        .forEach((order) =>
            finishedOrderItemsComponents.add(OrderHistoryItemComponent(
              order: order,
              onTap: () {
                Navigator.pushNamed(context, ReceiptView.ROUTE_NAME,
                    arguments: order);
              },
            )));

    return ScrollableParent(
        title: "Order History",
        appBarColor: IjudiColors.color1,
        hasDrawer: true,
        child: Stack(children: <Widget>[
          Headers.getHeader(context),
          Column(children: [
            pendingOrderItemsComponents.length == 1
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 32, top: 16),
                    margin: EdgeInsets.only(right: 4, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pendingOrderItemsComponents,
                    ),
                  ),
            finishedOrderItemsComponents.length == 1
                ? Container()
                : Container(
                    padding: EdgeInsets.only(bottom: 32, top: 16),
                    margin: EdgeInsets.only(right: 4, top: 16),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: finishedOrderItemsComponents,
                    ),
                  )
          ])
        ]));
  }
}
