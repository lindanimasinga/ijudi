import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/order-review-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/my-shop-order-update-view-model.dart';
import 'package:url_launcher/url_launcher.dart';

class MyShopOrderUpdateView
    extends MvStatefulWidget<MyShopOrderUpdateViewModel> {
  static const String ROUTE_NAME = "shop-order-update";

  MyShopOrderUpdateView({required MyShopOrderUpdateViewModel viewModel})
      : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        title: "Order Status",
        appBarColor: BreadCrumb.statusColors[3],
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
                            "Paid with ${describeEnum(viewModel.order.paymentType!)}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text("Order is a ${viewModel.orderType}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 8, left: 16),
                        child: Text("Customer: ${viewModel.customer?.name}",
                            style: IjudiStyles.HEADER_TEXT)),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 8, left: 16),
                      child: Row(children: [
                        Text("Chat Here: ", style: IjudiStyles.HEADER_TEXT),
                        Padding(padding: EdgeInsets.only(right: 8)),
                        GestureDetector(
                            child: Image.asset("assets/images/whatsapp.png",
                                width: 24),
                            onTap: () => launch(
                                "https://api.whatsapp.com/send?phone=${viewModel.customer?.mobileNumber}&text=Hello%20from%20iZinga"))
                      ]),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 32, left: 16),
                        child: InkWell(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Phone Number: ",
                                  style: IjudiStyles.HEADER_TEXT),
                              TextSpan(
                                  text: "${viewModel.customer?.mobileNumber}",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white))
                            ])),
                            onTap: () => launch(
                                "tel:${viewModel.customer?.mobileNumber}"))),
                    Container(
                        margin: EdgeInsets.only(right: 16),
                        child: OrderReviewComponent(
                          order: viewModel.order,
                          includeFees: false,
                          isCustomerView: false,
                        )),
                    (viewModel.orderReadyForCollection &&
                                viewModel.isDelivery) ||
                            viewModel.isInstoreOrder
                        ? Container()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    padding:
                                        EdgeInsets.only(top: 76, right: 16),
                                    child: IjudiForm(
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 140,
                                            child: Text(
                                                Utils.statusText[
                                                    viewModel.order.stage!]!,
                                                style: IjudiStyles.HEADER_2,
                                                textAlign: TextAlign.center)))),
                                Container(margin: EdgeInsets.only(top: 32)),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Buttons.iconButton(Icon(Icons.close),
                                          color: IjudiColors.color2,
                                          onPressed: () =>
                                              viewModel.rejectOrder()),
                                      Padding(
                                          padding: EdgeInsets.only(top: 16)),
                                      FloatingActionButtonWithProgress(
                                          viewModel: viewModel.progressMv,
                                          child: Icon(Icons.check),
                                          color: IjudiColors.color1,
                                          onPressed: () =>
                                              viewModel.progressNextStage()),
                                      Padding(padding: EdgeInsets.only(top: 8)),
                                    ])
                              ]),
                    Container(
                        margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                        child: Text("Messengers Available",
                            style: IjudiStyles.CONTENT_TEXT)),
                    Container(
                        margin: EdgeInsets.only(right: 16, top: 16, bottom: 16),
                        child: Column(
                            children: viewModel.messengers
                                .map((e) => GestureDetector(
                                      child: MessagerPreviewComponent(
                                          messenger: e,
                                          selected: () =>
                                              e == viewModel.selectedMessenger),
                                      onTap: () =>
                                          viewModel.selectedMessenger = e,
                                    ))
                                .toList()))
                  ]))
        ]));
  }
}
