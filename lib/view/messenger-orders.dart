import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-history-item-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/my-shop-order-update.dart';
import 'package:ijudi/viewmodel/messenger-orders-view-model.dart';

import 'messenger-order-update.dart';

class MessengerOrdersView extends MvStatefulWidget<MessengerOrdersViewModel> {
  static const ROUTE_NAME = "messenger-orders";

  MessengerOrdersView({required MessengerOrdersViewModel viewModel})
      : super(viewModel);

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

    viewModel.orders!
        .where((order) => order.stage != OrderStage.STAGE_7_ALL_PAID)
        .forEach((order) =>
            pendingOrderItemsComponents.add(OrderHistoryItemComponent(
                order: order,
                onTap: () {
                  if (viewModel.isStoreDone(order)) {
                    Navigator.pushNamed(
                        context, MessengerOrderUpdateView.ROUTE_NAME,
                        arguments: order);
                  }
                })));

    viewModel.orders!
        .where((order) => order.stage == OrderStage.STAGE_7_ALL_PAID)
        .forEach((order) =>
            finishedOrderItemsComponents.add(OrderHistoryItemComponent(
                order: order,
                onTap: () {
                  Navigator.pushNamed(context, MyShopOrderUpdateView.ROUTE_NAME,
                      arguments: order);
                })));

    return ScrollableParent(
        title: "Orders",
        hasDrawer: true,
        appBarColor: BreadCrumb.statusColors[3],
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
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
