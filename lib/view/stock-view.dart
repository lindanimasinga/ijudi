import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/components/stocks-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/stock-management-view-mode.dart';

class StockManagementView extends MvStatefulWidget<StockManagementViewModel> {
  static const ROUTE_NAME = "/stock";

  
  StockManagementView({StockManagementViewModel viewModel}) : super(viewModel);
  
  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
      hasDrawer: false,
      appBarColor: IjudiColors.color3,
      title: "Stock Management",
      child: Stack(
        children: <Widget>[
          Headers.getShopHeader(context),
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: ProfileHeaderComponent(
                    profile: viewModel.shop,
                    profilePicBorder: IjudiColors.color1
                  )
                ),
                Container(
                  alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Text("Add Stock Item",
                          style: IjudiStyles.HEADER_TEXT,
                        )
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IjudiForm(
                        child: Column(
                          children: <Widget>[
                            IjudiInputField(
                              hint: "Name",
                              text: viewModel.newItemName,
                            ),
                            IjudiInputField(
                              hint: "Price",
                              text: viewModel.newItemPrice,
                              type: TextInputType.number,
                            ),
                            IjudiInputField(
                              hint: "Quantity",
                              text: viewModel.newItemQuantity,
                              type: TextInputType.number,
                            ),
                          ],
                        ),
                      ), 
                      Padding(
                        padding: EdgeInsets.only(right: 16, bottom: 8),
                        child: FloatingActionButtonWithProgress(
                          viewModel: viewModel.progressMv,
                          onPressed: () => viewModel.addNewItem(),
                          child: Icon(Icons.check),)
                        )
                      ]
                  )
                ),
                Container(
                  alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Text("Available Items",
                          style: Forms.INPUT_TEXT_STYLE,
                        )
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 0, right: 16, bottom: 16),
                  child: StocksComponent(
                      stocks: viewModel.stocks,
                      addAction: (basketItem) => {

                      }
                  )
                )
            ],
          )
        ]
      ));
  }

}