import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-in-progress-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/final-order-view-model.dart';
import 'package:ijudi/viewmodel/order-progress-view-model.dart';

class FinalOrderView extends MvStatefulWidget<FinalOrderViewModel> {
  static const String ROUTE_NAME = "/finalOrder";

  FinalOrderView({FinalOrderViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: true,
        appBarColor: IjudiColors.color3,
        title: "Order Status",
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel,
                          stage: 0, 
                          countMinutes: 1),
                      label: "Order Number ${viewModel.order.id}",
                      text:
                          "Waiting for shop ${viewModel.shop.name} to accept your order. This may take a few minutes."),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: 1, 
                          countMinutes: 2),
                      text:
                          "${viewModel.shop.name} is now packing your order"),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: 2, 
                          countMinutes: 1),
                      text:
                          "Your order is on its way. Brace yourself.."),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: 3, 
                          countMinutes: 1),
                      text:
                          "${viewModel.order.shippingData.messenger.name} has arrived. Please come collect."),
                ],
              ))
        ]));
  }
}
