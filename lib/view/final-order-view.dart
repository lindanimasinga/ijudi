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

  FinalOrderView({required FinalOrderViewModel viewModel}) : super(viewModel);

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
                          order: viewModel.currentOrder,
                          stage: OrderStage.STAGE_1_WAITING_STORE_CONFIRM,
                      label: "Order Number ${viewModel.currentOrder.id}")),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          order: viewModel.currentOrder,
                          stage: OrderStage.STAGE_2_STORE_PROCESSING)),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          order: viewModel.currentOrder,
                          stage: OrderStage.STAGE_3_READY_FOR_COLLECTION)),
                  OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          order: viewModel.currentOrder,
                          stage: OrderStage.STAGE_4_ON_THE_ROAD)),
                                   OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          order: viewModel.currentOrder,
                          stage: OrderStage.STAGE_5_ARRIVED)),
                                            OrderProgressStageComponent(
                      viewModel: OrderProgressViewModel(
                          order: viewModel.currentOrder,
                          stage: OrderStage.STAGE_6_WITH_CUSTOMER)),
                      
                ],
              ))
        ]));
  }
}
