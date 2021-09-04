import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/basket-view-only-component.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-dropdown-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/ijudi-time-input-field.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/delivery-option-view-model.dart';
import 'package:intl/intl.dart';

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
                      child: Text("Basket", style: IjudiStyles.HEADER_TEXT)),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: 16, left: 0, right: 16, top: 16),
                    alignment: Alignment.center,
                    child:
                        BasketViewOnlyComponent(basket: viewModel.order!.basket),
                  ),
                  IjudiForm(
                      child: Row(
                    children: <Widget>[
                      Radio(
                        value: ShippingType.SCHEDULED_DELIVERY,
                        groupValue: viewModel.order!.shippingData!.type,
                        onChanged: (dynamic selection) =>
                            viewModel.shippingType = selection,
                      ),
                      Text('Deliver Later', style: Forms.INPUT_TEXT_STYLE),
                      Radio(
                        value: ShippingType.DELIVERY,
                        toggleable: viewModel.order!.shop!.deliverNowAllowed!,
                        groupValue: viewModel.order!.shippingData!.type,
                        onChanged: viewModel.order!.shop!.deliverNowAllowed!
                            ? (dynamic selection) => viewModel.shippingType = selection
                            : (dynamic selection) => {},
                      ),
                      Text('Deliver Now', style: Forms.INPUT_TEXT_STYLE)
                    ],
                  )),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  viewModel.isDeliveryNow
                      ? shippingDetailsWidget(messageComponents)
                      : collectionDetailsWidget(context, messageComponents),
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

  Widget shippingDetailsWidget(List<Widget> messageComponents) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      IjudiForm(
          child: Column(
        children: <Widget>[
          IjudiInputField(
              hint: "From Shop",
              enabled: false,
              text: viewModel.order!.shop!.name,
              color: IjudiColors.color5),
          IjudiDropDownField(
              hint: "Buidling Type",
              enabled: true,
              options: BuildingType.values,
              color: IjudiColors.color5,
              onSelected: (value) => viewModel.buildingType = value),
          !viewModel.isBuildingInfoRequired
              ? Container()
              : IjudiInputField(
                  hint: "Unit Number",
                  enabled: true,
                  text: viewModel.unitNumner,
                  color: IjudiColors.color5,
                  onChanged: (value) => viewModel.unitNumner = value),
          !viewModel.isBuildingInfoRequired
              ? Container()
              : IjudiInputField(
                  hint: "Building Name",
                  enabled: true,
                  text: viewModel.buildingName,
                  color: IjudiColors.color5,
                  onChanged: (value) => viewModel.buildingName = value),
          IjudiAddressInputField(
              hint: "Street Address",
              enabled: true,
              text: viewModel.deliveryAddress,
              color: IjudiColors.color5,
              onTap: (value) => viewModel.deliveryAddress = value),
        ],
      )),
      Padding(padding: EdgeInsets.only(top: 16)),
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          child: Text("Messengers Available", style: IjudiStyles.SUBTITLE_2)),
      Container(
          margin: EdgeInsets.only(bottom: 16, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: messageComponents))
    ]);
  }

  Widget collectionDetailsWidget(
      BuildContext context, List<Widget> messangersWidgets) {
    List<Widget> textSpans = [];
    viewModel.businessHours.forEach((time) {
      textSpans.add(Text(
          "${DateFormat('HH:mm').format(time.open!)} - ${DateFormat('HH:mm').format(time.close!)} ${describeEnum(time.day!)}",
          style: IjudiStyles.CONTENT_TEXT));
      textSpans.add(Padding(padding: EdgeInsets.only(top: 8)));
    });

    return Container(
        margin: EdgeInsets.only(top: 52),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                    "Please select the date and time we can delivery your order.",
                    style: IjudiStyles.CONTENT_TEXT)),
            Padding(padding: EdgeInsets.only(top: 16)),
            Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Text("Delivery Hours", style: IjudiStyles.HEADING)),
            Padding(padding: EdgeInsets.only(top: 16)),
            Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: textSpans)),
            Padding(padding: EdgeInsets.only(top: 8)),
            IjudiForm(
                child: IjudiTimeInput(
              hint: "Date",
              text: "${Utils.pickUpDay(viewModel.arrivalTime!, context)}",
              onChanged: (DateTime time) => viewModel.arrivalTime = time,
            )),
            Padding(padding: EdgeInsets.only(top: 8)),
            shippingDetailsWidget(messangersWidgets)
          ],
        ));
  }
}
