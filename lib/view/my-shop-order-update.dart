import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-review-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/my-shop-order-update-view-model.dart';

class MyShopOrderUpdateView extends MvStatefulWidget<MyShopOrderUpdateViewModel> {

  static const String ROUTE_NAME = "shop-order-update";
  
  static const statusText = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "Not Paid",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "Please confirm the order",
    OrderStage.STAGE_2_STORE_PROCESSING: "Have you started processing the order?",
    OrderStage.STAGE_3_READY_FOR_COLLECTION: "Is the order ready?",
    OrderStage.STAGE_4_ON_THE_ROAD: "Has the order been collected by the driver?",
    OrderStage.STAGE_5_ARRIVED: "Has the driver arrived?",
    OrderStage.STAGE_6_WITH_CUSTOMER: "Is the order delivered?",
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
              padding: EdgeInsets.only(top: 16, left: 0, right: 16),
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
                            "Paid with : ${viewModel.order.paymentType}",
                            style: IjudiStyles.HEADER_TEXT)),
                                        Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 32, left: 16),
                        child: Text("Order is a: ${viewModel.order.shippingData.type}",
                            style: IjudiStyles.HEADER_TEXT)),        
                    OrderReviewComponent(order: viewModel.order),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 76, left: 16, right: 16),
                        child: Text(statusText[viewModel.order.stage], 
                          style: IjudiStyles.HEADER_2,
                          textAlign: TextAlign.center)
                    ),
                    Container(margin: EdgeInsets.only(top: 32)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Buttons.iconButton(
                          Icon(Icons.close), 
                          color: IjudiColors.color2,
                          onPressed: () => viewModel.rejectOrder()),
                        Padding(padding: EdgeInsets.only(right: 32)),  
                        FloatingActionButtonWithProgress(
                          viewModel: viewModel.progressMv,
                          child: Icon(Icons.check), 
                          color: IjudiColors.color1,
                          onPressed: () => viewModel.progressNextStage())
                      ]
                    )
                  ]))
        ]));
  }
}
