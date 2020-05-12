import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/my-shops-view-model.dart';

class MyShopsView extends MvStatefulWidget<MyShopsViewModel> {
  
  static const String ROUTE_NAME = "myshops";

  MyShopsView({viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
      hasDrawer: true,
      appBarColor: IjudiColors.color3,
      title: "My Shops",
      child: Stack(
        children: <Widget>[
          Headers.getShopHeader(context),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: ProfileHeaderComponent(
                    profile: viewModel.shop,
                    profilePicBorder: IjudiColors.color1
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                  child: Text("About The Shop", 
                            style: IjudiStyles.SUBTITLE_1
                          ),
                ),
                IjudiForm( 
                  child: Column(
                          children: <Widget>[
                            IjudiInputField(hint: 'Shop Name', type: TextInputType.phone, text: viewModel.shop.name),
                            IjudiInputField(hint: 'Company Reg Number', type: TextInputType.visiblePassword, text: viewModel.shop.registrationNumber),
                            IjudiInputField(hint: 'Description', type: TextInputType.text, text: viewModel.shop.description),
                            IjudiInputField(hint: 'Years in service', type: TextInputType.text, text: "${viewModel.shop.yearsInService}"),
                            IjudiAddressInputField(hint: 'Address', type: TextInputType.number, text: viewModel.shop.address)
                          ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                  child: Text("Bank", 
                            style: IjudiStyles.SUBTITLE_2
                          ),
                ),
                IjudiForm( 
                  child: Column(
                        children: <Widget>[
                          IjudiInputField(hint: 'Bank Name', type: TextInputType.text, text: viewModel.shop.bank.name),
                          IjudiInputField(hint: 'Account Number', type: TextInputType.text, text: viewModel.shop.bank.account),
                          IjudiInputField(hint: 'Account Type', type: TextInputType.text, text: viewModel.shop.bank.type)
                        ],
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(16),
                    child: FloatingActionButton(
                      onPressed: null,
                      child: Icon(Icons.check),
                      ),
                  )
              ],
            )
          )
        ],
    ));
  }
}