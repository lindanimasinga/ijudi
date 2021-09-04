import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/stocks-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/stock-add-new.dart';
import 'package:ijudi/viewmodel/stock-add-new-view-model.dart';
import 'package:ijudi/viewmodel/stock-management-view-mode.dart';

class StockManagementView extends MvStatefulWidget<StockManagementViewModel> {
  static const ROUTE_NAME = "/stock";

  StockManagementView({required StockManagementViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color1,
        title: "Stock Management",
        child: Stack(children: <Widget>[
          Headers.getHeader(context),
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: ProfileHeaderComponent(
                      profile: viewModel.shop,
                      profilePicBorder: IjudiColors.color3)),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Stock Item",
                          style: IjudiStyles.HEADER_TEXT,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 16, bottom: 8),
                            child: FloatingActionButtonWithProgress(
                              viewModel: viewModel.progressMv,
                              onPressed: () => Navigator.pushNamed(
                                  context, StockAddNewView.ROUTE_NAME,
                                  arguments: StockAddNewInput(viewModel.shop, null)),
                              child: Icon(Icons.add),
                            ))
                      ])),
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Text(
                    "Available Items",
                    style: Forms.INPUT_TEXT_STYLE,
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 0, right: 16, bottom: 16),
                  child: StocksComponent(
                      stocks: viewModel.stocks,
                      actionName: "Edit",
                      enabledAction : true,
                      action: (stockItem) => Navigator.pushNamed(
                                  context, StockAddNewView.ROUTE_NAME,
                                  arguments: StockAddNewInput(viewModel.shop, stockItem))))
            ],
          )
        ]));
  }
}
