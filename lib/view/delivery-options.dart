import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/components/busket-view-only-component.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/delivery-option-view-model.dart';

class DeliveryOptionsView extends MvStatefulWidget<DeliveryOptionsViewModel> {
  
  static const String ROUTE_NAME = "delivery";

  DeliveryOptionsView({viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    List<Widget> messageComponents = [];
    viewModel.messangers.forEach((mess) {
      messageComponents.add(MessagerPreviewComponent(messenger: mess));
    });

    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color3,
        title: "Delivery",
        child: Stack(children: <Widget>[
          Headers.getShopHeader(context),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text("Busket", style: IjudiStyles.HEADER_TEXT)),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 16, left: 16, right: 16, top: 16),
                    alignment: Alignment.center,
                    child: BusketViewOnlyComponent(busket: viewModel.busket),
                  ),
                  IjudiForm(
                      child: Row(
                    children: <Widget>[
                      Radio(
                        value: ShippingType.COLLECTION,
                        groupValue: viewModel.newOrder.shippingData.type,
                        onChanged: (selection) => viewModel.delivery = selection,
                      ),
                      Text('Collection', style: Forms.INPUT_TEXT_STYLE),
                      Radio(
                        value: ShippingType.DELIVERY,
                        groupValue: viewModel.newOrder.shippingData.type,
                        onChanged: (selection) => viewModel.delivery = selection,
                      ),
                      Text('Delivery', style: Forms.INPUT_TEXT_STYLE)
                    ],
                  )),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  IjudiForm(
                      child: Column(
                    children: <Widget>[
                      IjudiInputField(
                          hint: "From Shop",
                          enabled: false,
                          text: viewModel.busket.shop.name,
                          color: IjudiColors.color5),
                      IjudiAddressInputField(
                          hint: "To Address",
                          enabled: true,
                          text: viewModel.deliveryAddress,
                          color: IjudiColors.color5,
                          onTap: (value) => viewModel.deliveryAddress = value),
                    ],
                  )),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 16),
                      child: Text("Messangers Available",
                          style: IjudiStyles.SUBTITLE_2)),
                  Container(
                      margin: EdgeInsets.only(bottom: 16),
                      alignment: Alignment.center,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: messageComponents)),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: FloatingActionButtonWithProgress(
                      viewModel: viewModel.progressMv,
                      onPressed: () => viewModel.startOrder(),
                      child: Icon(Icons.arrow_forward),
                    ),
                  )
                ]),
          )
        ]));
  }

}
