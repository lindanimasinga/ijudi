import 'package:flutter/material.dart';
import 'package:ijudi/components/bread-crumb.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-dropdown-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/ijudi-switch-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/profile-header-component.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/shop-profile-view-model.dart';

class ShopProfileView extends MvStatefulWidget<ShopProfileViewModel> {
  static const String ROUTE_NAME = "shop-profile";

  ShopProfileView({required ShopProfileViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: BreadCrumb.statusColors[2],
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
                            profile: viewModel.shop!,
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
                              text: viewModel.shop!.name),
                          IjudiInputField(
                              hint: 'Company Reg Number',
                              autofillHints: [AutofillHints.creditCardNumber],
                              type: TextInputType.visiblePassword,
                              text: viewModel.shop!.registrationNumber),
                          IjudiInputField(
                              hint: 'Description',
                              autofillHints: [AutofillHints.name],
                              type: TextInputType.text,
                              text: viewModel.shop!.description),
                          IjudiInputField(
                              hint: 'Years in service',
                              type: TextInputType.text,
                              text: "${viewModel.shop!.yearsInService}"),
                          IjudiAddressInputField(
                              hint: 'Address',
                              type: TextInputType.number,
                              text: viewModel.address,
                              onTap: (value) => viewModel.address = value)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: Text("Bank Information",
                          style: IjudiStyles.HEADER_TEXT),
                    ),
                    IjudiForm(
                      child: AutofillGroup(
                          child: Column(
                        children: <Widget>[
                          IjudiInputField(
                            hint: 'Bank Name',
                            autofillHints: [AutofillHints.name],
                            text: viewModel.shop?.bank?.name,
                            onChanged: (number) =>
                                viewModel.shop?.bank?.name = number,
                            type: TextInputType.phone,
                          ),
                          IjudiInputField(
                              text: viewModel.shop?.bank?.accountId,
                              onChanged: (name) =>
                                  viewModel.shop?.bank?.accountId = name,
                              autofillHints: [AutofillHints.name],
                              hint: 'Account No.',
                              type: TextInputType.text),
                          IjudiInputField(
                              text: viewModel.shop!.bank?.branchCode,
                              onChanged: (name) =>
                                  viewModel.shop!.bank?.branchCode = name,
                              autofillHints: [AutofillHints.name],
                              hint: 'Branch Code',
                              type: TextInputType.text),
                          IjudiDropDownField(
                              hint: "Account Type",
                              enabled: true,
                              options: BankAccType.values,
                              color: IjudiColors.color5,
                              initial: viewModel.shop?.bank?.type,
                              onSelected: (value) =>
                                  viewModel.shop?.bank?.type = value),
                        ],
                      )),
                    ),
                    IjudiForm(
                      child: IjudiSwitchInputField(
                          active: !viewModel.shop!.storeOffline,
                          label: "Active",
                          onChanged: (bool online) {
                            viewModel.shop!.storeOffline = !online;
                            viewModel.shop!.availability =
                                online ? "SPECIFIC_HOURS" : "OFFLINE";
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
