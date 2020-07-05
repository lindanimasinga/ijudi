import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-review-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/my-shop-order-update-view-model.dart';

class MyShopOrderUpdateView
    extends MvStatefulWidget<MyShopOrderUpdateViewModel> {
  static const String ROUTE_NAME = "shop-order-update";

  static const statusText = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "Not Paid",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "Please confirm the order",
    OrderStage.STAGE_2_STORE_PROCESSING: "Is the order ready?",
    OrderStage.STAGE_3_READY_FOR_COLLECTION:
        "Has the order been collected by the driver?",
    OrderStage.STAGE_4_ON_THE_ROAD: "Has the driver arrived at the Customer?",
    OrderStage.STAGE_5_ARRIVED: "Is the order delivered?",
    OrderStage.STAGE_6_WITH_CUSTOMER: "The order delivered",
    OrderStage.STAGE_7_PAID_SHOP: "Completed"
  };

  MyShopOrderUpdateView({MyShopOrderUpdateViewModel viewModel})
      : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        title: "Order Status",
        appBarColor: IjudiColors.color3,
        hasDrawer: false,
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text("Order: ${viewModel.order.id}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text(
                            "Paid with ${describeEnum(viewModel.order.paymentType)}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 32, left: 16),
                        child: Text(
                            "Order is a ${describeEnum(viewModel.order.shippingData.type)}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        margin: EdgeInsets.only(right: 16),
                        child: OrderReviewComponent(order: viewModel.order)
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(top: 76, right: 16),
                          child: IjudiForm(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 140,
                                  child: Text(statusText[viewModel.order.stage],
                                      style: IjudiStyles.HEADER_2,
                                      textAlign: TextAlign.center)))),
                      Container(margin: EdgeInsets.only(top: 32)),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Buttons.iconButton(Icon(Icons.close),
                                color: IjudiColors.color2,
                                onPressed: () => viewModel.rejectOrder()),
                            Padding(padding: EdgeInsets.only(top: 16)),
                            FloatingActionButtonWithProgress(
                                viewModel: viewModel.progressMv,
                                child: Icon(Icons.check),
                                color: IjudiColors.color1,
                                onPressed: () => viewModel.progressNextStage()),
                            Padding(padding: EdgeInsets.only(top: 8)),
                          ])
                    ])
                  ]))
        ]));
  }
}
