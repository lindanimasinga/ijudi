import 'package:flutter/material.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-in-progress-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
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
                          stage: OrderStage.STAGE_1_WAITING_STORE_CONFIRM, 
                          countMinutes: 1),
                      label: "Order Number ${viewModel.order.id}",
                      text:
                          "Waiting for shop ${viewModel.shop.name} to accept your order. This may take a few minutes."),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: OrderStage.STAGE_2_STORE_PROCESSING, 
                          countMinutes: 2),
                      text:
                          "${viewModel.shop.name} is now processing your order"),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: OrderStage.STAGE_3_READY_FOR_COLLECTION, 
                          countMinutes: 1),
                      text:
                          "The driver is now collecting your. Brace yourself.."),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: OrderStage.STAGE_4_ON_THE_ROAD, 
                          countMinutes: 1),
                      text:
                          "The driver is on his way"),
                                   OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: OrderStage.STAGE_5_ARRIVED, 
                          countMinutes: 1),
                      text:
                          "The driver has arrived. Please come collect."),
                                            OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          orderViewModel: viewModel, 
                          stage: OrderStage.STAGE_6_WITH_CUSTOMER, 
                          countMinutes: 1),
                      text:
                          "The driver you have received your order, Give us a review."),
                      
                ],
              ))
        ]));
  }
}
