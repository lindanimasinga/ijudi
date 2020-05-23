
import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-history-item-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/order-history-view-model.dart';

class OrderHistoryView extends MvStatefulWidget<OrderHistoryViewModel> {
  
  static const ROUTE_NAME = "order-history";
  
  OrderHistoryView({OrderHistoryViewModel viewModel}) : super(viewModel);
  
  @override
  Widget build(BuildContext context) {
    
    List<OrderHistoryItemComponent> orderItemsComponents = [];
    viewModel.orders.forEach((order) => orderItemsComponents.add(OrderHistoryItemComponent(order: order)));

    return ScrollableParent(
      title: "Order History",
      appBarColor: IjudiColors.color3,
      hasDrawer: true,
      child: Stack(
        children: <Widget>[
          Headers.getShopHeader(context),
          Container(
            child: Column(
              children: orderItemsComponents,
            ),
          )
        ]
      )
    );
  }
  
}