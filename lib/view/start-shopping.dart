import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/components/busket-component.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/stocks-component.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/busket-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/delivery-options.dart';

class StartShoppingView extends StatefulWidget {
  
  static const ROUTE_NAME = "start-shopping";
  final Shop shop;

  StartShoppingView({@required this.shop});

  @override
  _StartShoppingViewState createState() => _StartShoppingViewState(shop);
}

class _StartShoppingViewState extends State<StartShoppingView> {
  List<Stock> stock;
  Busket busket;
  Shop storeProfile;

  _StartShoppingViewState(this.storeProfile);

  @override
  void initState() {
    super.initState();
    stock = ApiService.findAllStockByShopId(storeProfile.id);
    UserProfile user = ApiService.findUserById("s");
    busket = BusketService().createNew(user, storeProfile);
  }

  

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color3,
        title: "Shopping",
        child: Stack(
          children: <Widget>[
            Headers.getShopHeader(context),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: ProfileHeaderComponent(
                            profile: storeProfile,
                            profilePicBorder: IjudiColors.color1)),
                    Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 16),
                        child: Forms.searchField(
                            context, "bread, sugar, airtime")),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Busket",style: IjudiStyles.HEADER_TEXT),
                            FloatingActionButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, DeliveryOptions.ROUTE_NAME,
                                  arguments: busket),
                              child: Icon(Icons.arrow_forward)
                              )
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: BusketComponent(
                            busket: busket,
                            removeAction: (busketItem) {
                              setState(() {
                                print("changed");
                                busket.removeOneItem(busketItem);
                                stock
                                    .firstWhere(
                                        (elem) => elem.name == busketItem.name)
                                    .put(1);
                              });
                            })),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Text(
                          "Available Items",
                          style: Forms.INPUT_TEXT_STYLE,
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: StocksComponent(
                            stock: stock,
                            addAction: (busketItem) {
                              setState(() {
                                busket.addItem(busketItem);
                                print("changed");
                              });
                            }))
                  ],
                ))
          ],
        ));
  }
}
