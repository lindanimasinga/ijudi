import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/components/busket-view-only-component.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/payment-view.dart';

class DeliveryOptions extends StatefulWidget {
  final Busket busket;
  static const String ROUTE_NAME = "delivery";

  DeliveryOptions({@required this.busket});

  @override
  _StateDeliveryOptions createState() => _StateDeliveryOptions(this.busket);
}

class _StateDeliveryOptions extends State<DeliveryOptions> {
  static const kGoogleApiKey = "AIzaSyAZbvE4NBcJIplfzmy8cSEdSpbocBggylc";
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  Busket busket;
  List<UserProfile> messangers;
  bool _delivery = true;
  Order newOrder;

  _StateDeliveryOptions(this.busket);

  @override
  void initState() {
    messangers = ApiService.findNearbyMessangers("");
    newOrder = Order();
    newOrder.busket = busket;
    newOrder.shippingData = Shipping();
    newOrder.shippingData.type = ShippingType.COLLECTION;
    newOrder.shippingData.messanger = messangers[0];
    newOrder.shippingData.fromAddress = busket.shop.name;
    newOrder.shippingData.toAddress= busket.customer.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> messageComponents = [];
    messangers.forEach((mess) {
      messageComponents.add(MessagerPreviewComponent(mess));
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
                    child: BusketViewOnlyComponent(busket: busket),
                  ),
                  IjudiForm(
                      child: Row(
                    children: <Widget>[
                      Radio(
                        value: ShippingType.COLLECTION,
                        groupValue: newOrder.shippingData.type,
                        onChanged: (selection) => delivery = selection,
                      ),
                      Text('Collection', style: Forms.INPUT_TEXT_STYLE),
                      Radio(
                        value: ShippingType.DELIVERY,
                        groupValue: newOrder.shippingData.type,
                        onChanged: (selection) => delivery = selection,
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
                          text: busket.shop.name,
                          color: IjudiColors.color5),
                      IjudiAddressInputField(
                          hint: "To Address",
                          enabled: true,
                          text: customerAddress,
                          color: IjudiColors.color5,
                          onTap: (value) => delivery = value),
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
                    child: FloatingActionButton(
                      onPressed: () => Navigator.pushNamed(
                                  context, PaymentView.ROUTE_NAME,
                                  arguments: newOrder),
                      child: Icon(Icons.arrow_forward),
                    ),
                  )
                ]),
          )
        ]));
  }

  get delivery => newOrder.shippingData.type;
  set delivery(ShippingType value) {
    newOrder.shippingData.type = value;
    setState(() {});
  }

  get customerAddress => newOrder.busket.customer.address;
  set customerAddress(String value) {
    newOrder.busket.customer.address = value;
    setState(() {});
  }

  openAddressFinder() async {
    print("changed");
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.fullscreen, // Mode.fullscreen
        language: "za",
        components: [Component(Component.country, "za")]);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      customerAddress = detail.result.formattedAddress;
    }
  }
}
