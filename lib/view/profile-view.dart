import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-dropdown-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/ijudi-switch-input-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/supported-location.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/profile-view-model.dart';

class ProfileView extends MvStatefulWidget<ProfileViewModel> {
  static const ROUTE_NAME = "profile";

  ProfileView({required ProfileViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: true,
        appBarColor: IjudiColors.color1,
        title: "Profile",
        child: Stack(
          children: <Widget>[
            Headers.getHeader(context),
            viewModel.userProfile == null
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, top: 24, bottom: 16),
                          child: Text("Profile Picture",
                              style: IjudiStyles.SUBTITLE_1),
                        ),
                        FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(75),
                                      bottomRight: Radius.circular(75)),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: IjudiColors.color1,
                                    width: 4,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        viewModel.userProfile!.imageUrl!),
                                    fit: BoxFit.contain,
                                  ),
                                ))),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, top: 24, bottom: 16),
                          child:
                              Text("Personal", style: IjudiStyles.HEADER_TEXT),
                        ),
                        IjudiForm(
                          child: AutofillGroup(
                              child: Column(
                            children: <Widget>[
                              IjudiInputField(
                                hint: 'Cell Number',
                                autofillHints: [AutofillHints.telephoneNumber],
                                text: viewModel.userProfile!.mobileNumber,
                                onChanged: (number) => viewModel
                                    .userProfile!.mobileNumber = number,
                                type: TextInputType.phone,
                              ),
                              IjudiInputField(
                                  text: viewModel.userProfile!.name,
                                  onChanged: (name) =>
                                      viewModel.userProfile!.name = name,
                                  autofillHints: [AutofillHints.name],
                                  hint: 'Name',
                                  type: TextInputType.text),
                              IjudiAddressInputField(
                                  text: viewModel.userProfile!.address,
                                  onTap: (SupportedLocation address) {
                                    viewModel.userProfile?.address =
                                        address.name;
                                    viewModel.userProfile?.latitude =
                                        address.latitude;
                                    viewModel.userProfile?.longitude =
                                        address.longitude;
                                  },
                                  hint: 'Physical Address',
                                  type: TextInputType.number),
                              IjudiSwitchInputField(
                                  active: viewModel
                                          .userProfile!.availabilityStatus ==
                                      ProfileAvailabilityStatus.ONLINE,
                                  label: "Active",
                                  onChanged: (bool online) {
                                    viewModel.userProfile!.availabilityStatus =
                                        online
                                            ? ProfileAvailabilityStatus.ONLINE
                                            : ProfileAvailabilityStatus.OFFLINE;
                                  })
                            ],
                          )),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, top: 16, bottom: 16),
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
                                text: viewModel.userProfile?.bank?.name,
                                onChanged: (number) =>
                                    viewModel.userProfile?.bank?.name = number,
                                type: TextInputType.phone,
                              ),
                              IjudiInputField(
                                  text: viewModel.userProfile?.bank?.accountId,
                                  onChanged: (name) => viewModel
                                      .userProfile?.bank?.accountId = name,
                                  autofillHints: [AutofillHints.name],
                                  hint: 'Account No.',
                                  type: TextInputType.text),
                              IjudiInputField(
                                  text: viewModel.userProfile!.bank?.branchCode,
                                  onChanged: (name) => viewModel
                                      .userProfile!.bank?.branchCode = name,
                                  autofillHints: [AutofillHints.name],
                                  hint: 'Branch Code',
                                  type: TextInputType.text),
                              IjudiDropDownField(
                                  hint: "Account Type",
                                  enabled: true,
                                  options: BankAccType.values,
                                  color: IjudiColors.color5,
                                  initial: viewModel.userProfile?.bank?.type,
                                  onSelected: (value) => viewModel
                                      .userProfile?.bank?.type = value),
                            ],
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          alignment: Alignment.center,
                          child: FloatingActionButtonWithProgress(
                            viewModel: viewModel.progressMv,
                            child: Icon(Icons.check),
                            onPressed: () => {viewModel.updareUser()},
                          ),
                        )
                      ],
                    ))
          ],
        ));
  }
}
