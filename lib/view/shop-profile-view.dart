import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/ijudi-switch-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/shop-profile-view-model.dart';

class ShopProfileView extends MvStatefulWidget<ShopProfileViewModel> {
  static const String ROUTE_NAME = "shop-profile";

  ShopProfileView({ShopProfileViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
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
                            profilePicBorder: IjudiColors.color1)),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                      child:
                          Text("About The Shop", style: IjudiStyles.SUBTITLE_1),
                    ),
                    IjudiForm(
                      child: Column(
                        children: <Widget>[
                          IjudiInputField(
                              hint: 'Shop Name',
                              autofillHints: [AutofillHints.name],
                              type: TextInputType.phone,
                              text: viewModel.shop.name),
                          IjudiInputField(
                              hint: 'Company Reg Number',
                              autofillHints: [AutofillHints.creditCardNumber],
                              type: TextInputType.visiblePassword,
                              text: viewModel.shop.registrationNumber),
                          IjudiInputField(
                              hint: 'Description',
                              autofillHints: [AutofillHints.name],
                              type: TextInputType.text,
                              text: viewModel.shop.description),
                          IjudiInputField(
                              hint: 'Years in service',
                              type: TextInputType.text,
                              text: "${viewModel.shop.yearsInService}"),
                          IjudiAddressInputField(
                              hint: 'Address',
                              type: TextInputType.number,
                              text: viewModel.address,
                              onTap: (value) => viewModel.address = value)
                        ],
                      ),
                    ),
                    IjudiForm(
                      child: IjudiSwitchInputField(
                          active: !viewModel.shop.storeOffline,
                          label: "Active",
                          onChanged: (bool online) {
                                viewModel.shop.storeOffline = !online;
                                viewModel.shop.availability = online ? "SPECIFIC_HOURS" : "OFFLINE";
                              }),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(16),
                      child: FloatingActionButtonWithProgress(
                        viewModel: viewModel.progressMv,
                        onPressed: () => viewModel.updateProfile(),
                        child: Icon(Icons.check),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
