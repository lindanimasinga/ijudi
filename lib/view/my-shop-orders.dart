import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-history-item-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/my-shop-order-update.dart';
import 'package:ijudi/viewmodel/myshop-orders-view-model.dart';

class MyShopOrdersView extends MvStatefulWidget<MyShopOrdersViewModel> {
  static const ROUTE_NAME = "myshop-orders";

  MyShopOrdersView({MyShopOrdersViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    List<Widget> pendingOrderItemsComponents = [
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Current Orders", style: IjudiStyles.HEADER_2_WHITE)),
    ];

    List<Widget> scheduledOrderItemsComponents = [
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Scheduled Orders", style: IjudiStyles.HEADER_2)),
    ];

    List<Widget> finishedOrderItemsComponents = [
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Past Orders", style: IjudiStyles.HEADER_2)),
    ];

    viewModel.orders
        .where((order) => order.stage != OrderStage.STAGE_7_ALL_PAID)
        .where((order) =>
            viewModel.isCurrentOrder(order))
        .forEach((order) =>
            pendingOrderItemsComponents.add(OrderHistoryItemComponent(
                order: order,
                onTap: () {
                  Navigator.pushNamed(context, MyShopOrderUpdateView.ROUTE_NAME,
                      arguments: order);
                })));

    viewModel.orders
        .where((order) => order.stage != OrderStage.STAGE_7_ALL_PAID)
        .where((order) => order.shippingData.type == ShippingType.COLLECTION)
        .where((order) =>
            !viewModel.isCurrentOrder(order))
        .forEach((order) =>
            scheduledOrderItemsComponents.add(OrderHistoryItemComponent(
                order: order,
                onTap: () {
                  Navigator.pushNamed(context, MyShopOrderUpdateView.ROUTE_NAME,
                      arguments: order);
                })));

    viewModel.orders
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
        appBarColor: IjudiColors.color3,
        hasDrawer: false,
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
            scheduledOrderItemsComponents.length == 1
                ? Container()
                : Container(
                    padding: EdgeInsets.only(bottom: 32, top: 16),
                    margin: EdgeInsets.only(right: 4, top: 16),
                    alignment: Alignment.topLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: scheduledOrderItemsComponents)),
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
