import 'package:flutter/material.dart';
import 'package:ijudi/components/busket-component.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/stocks-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/viewmodel/start-shopping-view-model.dart';

class StartShoppingView extends MvStatefulWidget<StartShoppingViewModel> {
  
  static const ROUTE_NAME = "start-shopping";

  StartShoppingView({viewModel}) : super(viewModel);

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
                            profile: viewModel.shop,
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
                            FloatingActionButtonWithProgress(
                              viewModel: viewModel.progressMv,
                              onPressed: () => viewModel.verifyItemsAvailable(),
                              child: Icon(Icons.arrow_forward)
                              )
                          ],
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: BusketComponent(
                            busket: viewModel.busket,
                            removeAction: (busketItem) =>
                                viewModel.remove(busketItem))),
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
                            stock: viewModel.stock,
                            addAction: (busketItem) =>
                                viewModel.add(busketItem)))
                  ],
                ))
          ],
        ));
  }
}
