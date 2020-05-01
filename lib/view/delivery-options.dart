import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/components/busket-view-only-component.dart';
import 'package:ijudi/components/messager-preview-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/theme-utils.dart';

class DeliveryOptions extends StatefulWidget {
  final Busket busket;
  static const String ROUTE_NAME = "delivery";

  DeliveryOptions({@required this.busket});

  @override
  _StateDeliveryOptions createState() => _StateDeliveryOptions(this.busket);
}

class _StateDeliveryOptions extends State<DeliveryOptions> {
  
  Busket busket;
  List<UserProfile> messangers;
  bool _delivery = true;

  _StateDeliveryOptions(this.busket);

  @override
  void initState() {
    messangers = ApiService.findNearbyMessangers("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> messageComponents = [];
    messangers.forEach((mess) {
      messageComponents.add(
        MessagerPreviewComponent(mess)
      );
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
                    child:Text("Busket", style: IjudiStyles.HEADER_TEXT)
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
                    alignment: Alignment.center,
                    child: BusketViewOnlyComponent(busket: busket),
                  ),
                  Forms.create(
                      child: Row(
                    children: <Widget>[
                      Radio(
                        value: false,
                        groupValue: delivery,
                        onChanged: (selection) => delivery = selection,
                      ),
                      Text('Collection', style: Forms.INPUT_TEXT_STYLE),
                      Radio(
                        value: true,
                        groupValue: delivery,
                        onChanged: (selection) => delivery = selection,
                      ),
                      Text('Delivery',style: Forms.INPUT_TEXT_STYLE)
                    ],
                  )),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Forms.create(
                    child: Column(children: <Widget>[
                      Forms.inputField(hint: "From Shop",enabled: false,text: busket.shop.name),
                      Forms.inputField(hint: "To Address",enabled: false,text: busket.userProfile.address)
                    ],)
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 16),
                    child:Text("Messangers Available", style: IjudiStyles.SUBTITLE_2)
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: messageComponents
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: FloatingActionButton(
                      onPressed: null,
                      child: Icon(Icons.arrow_forward),
                      ),
                  )
                ]),
              )
        ]));
  }

  get delivery  => _delivery;
  set delivery(bool value) {
    _delivery = value;
      setState(() {
    });
  }
}
