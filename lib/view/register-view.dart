import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-address-input-field.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-input-field.dart';
import 'package:ijudi/components/ijudi-login-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/register-view-model.dart';

class RegisterView extends MvStatefulWidget<RegisterViewModel> {
  static const ROUTE_NAME = "register";

  RegisterView({RegisterViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    //viewModel.progressMv.isBusy = false;
    return ScrollableParent(
        hasDrawer: false,
        appBarColor: IjudiColors.color1,
        title: "Registration",
        child: Stack(
          children: <Widget>[
            Headers.getHeader(context),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
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
                                image: NetworkImage(viewModel.imageUrl),
                                fit: BoxFit.contain,
                              ),
                            ))),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                      child: Text("What is your interest onto iZinga?",
                          style: IjudiStyles.HEADER_TEXT),
                    ),
                    IjudiForm(
                        child: Column(children: [
                      Row(
                        children: <Widget>[
                          Radio(
                            value: ProfileRoles.CUSTOMER,
                            groupValue: viewModel.interests,
                            onChanged: (selection) =>
                                viewModel.interests = selection,
                          ),
                          Text('I want buy my favourite food',
                              style: Forms.INPUT_TEXT_STYLE),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: ProfileRoles.STORE,
                            groupValue: viewModel.interests,
                            onChanged: (selection) =>
                                viewModel.interests = selection,
                          ),
                          Text('I want to sell food online',
                              style: Forms.INPUT_TEXT_STYLE),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: ProfileRoles.MESSENGER,
                            groupValue: viewModel.interests,
                            onChanged: (selection) =>
                                viewModel.interests = selection,
                          ),
                          Text('I want to deliver food',
                              style: Forms.INPUT_TEXT_STYLE),
                        ],
                      )
                    ])),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                      child: Text("Personal Information"),
                    ),
                    IjudiForm(
                      child: AutofillGroup(
                          child: Column(
                        children: <Widget>[
                          IjudiInputField(
                            hint: 'SA Mobile Number',
                            autofillHints: [
                              AutofillHints.telephoneNumber,
                              AutofillHints.telephoneNumberLocal
                            ],
                            text: viewModel.mobileNumber,
                            error: () => viewModel.mobileNumberValid
                                ? ""
                                : "Invalid SA mobile number",
                            onChanged: (number) =>
                                viewModel.mobileNumber = number,
                            type: TextInputType.phone,
                          ),
                          IjudiInputField(
                              text: viewModel.name,
                              onChanged: (name) => viewModel.name = name,
                              autofillHints: [AutofillHints.name],
                              hint: 'Name',
                              error: () =>
                                  viewModel.nameValid ? "" : "Invalid name",
                              type: TextInputType.text),
                          IjudiInputField(
                              text: viewModel.lastname,
                              onChanged: (lastname) =>
                                  viewModel.lastname = lastname,
                              hint: 'Surname',
                              error: () => viewModel.lastNameValid
                                  ? ""
                                  : "Invalid surname",
                              autofillHints: [AutofillHints.familyName],
                              type: TextInputType.text),
                          /* IjudiInputField(
                              text: viewModel.idNumber,
                              onTap: (id) => viewModel.idNumber = id,
                              hint: 'Id Number',
                              autofillHints: ["idNumber"],
                              type: TextInputType.text),*/
                          IjudiInputField(
                              text: viewModel.email,
                              onChanged: (email) => viewModel.email = email,
                              hint: 'Email Address',
                              autofillHints: [AutofillHints.email],
                              type: TextInputType.emailAddress),
                          IjudiAddressInputField(
                              text: viewModel.address,
                              onTap: (address) => viewModel.address = address,
                              hint: 'Physical Address',
                              type: TextInputType.number)
                        ],
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
                      child: Text("Do you have an Ukheshe Account?"),
                    ),
                    IjudiForm(
                        child: Row(
                      children: <Widget>[
                        Radio(
                          value: true,
                          groupValue: viewModel.hasUkheshe,
                          onChanged: (selection) =>
                              viewModel.hasUkheshe = selection,
                        ),
                        Text('Yes', style: Forms.INPUT_TEXT_STYLE),
                        Radio(
                          value: false,
                          groupValue: viewModel.hasUkheshe,
                          onChanged: (selection) =>
                              viewModel.hasUkheshe = selection,
                        ),
                        Text('No', style: Forms.INPUT_TEXT_STYLE)
                      ],
                    )),
                    !viewModel.hasUkheshe
                        ? Container()
                        : Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 8, bottom: 16),
                            child: Image.asset("assets/images/uKhese-logo.png",
                                width: 90),
                          ),
                    viewModel.hasUkheshe
                        ? Padding(
                            padding: EdgeInsets.only(left: 16, bottom: 4),
                            child: Text(
                                "Please register with your Ukheshe details"))
                        : Container(),
                    !viewModel.hasUkheshe
                        ? Container()
                        : IjudiForm(
                            child: Column(
                              children: <Widget>[
                                IjudiInputField(
                                    text: viewModel.mobileNumber,
                                    onChanged: (phone) =>
                                        viewModel.mobileNumber = phone,
                                    hint: 'SA Mobile Number',
                                    autofillHints: [
                                      AutofillHints.telephoneNumber
                                    ],
                                    type: TextInputType.phone),
                                !viewModel.hasUkheshe
                                    ? Container()
                                    : IjudiLoginField(
                                        onTap: (pass) =>
                                            viewModel.password = pass,
                                        hint: 'Password',
                                        icon: Icon(
                                          Icons.lock,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        autofillHints: [AutofillHints.password],
                                        type: TextInputType.text)
                              ],
                            ),
                          ),
                    IjudiForm(
                      child: Column(
                        children: <Widget>[
                          viewModel.hasUkheshe
                              ? Container()
                              : IjudiLoginField(
                                  onTap: (pass) => viewModel.password = pass,
                                  hint: 'Create Password',
                                  icon: Icon(
                                    Icons.lock,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  autofillHints: [AutofillHints.newPassword],
                                  type: TextInputType.text),
                          viewModel.hasUkheshe
                              ? Container()
                              : IjudiLoginField(
                                  onTap: (pass) =>
                                      viewModel.passwordConfirm = pass,
                                  hint: 'Confirm Password',
                                  error: () => viewModel.passwordValid
                                      ? ""
                                      : "passwords not match",
                                  icon: Icon(
                                    Icons.lock,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  autofillHints: [AutofillHints.newPassword],
                                  type: TextInputType.text)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16),
                      child: Text(
                        viewModel.ukhesheMessage,
                        style: IjudiStyles.SUBTITLE_2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: InkWell(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "iZinga Food Market Terms and Conditions",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue))
                          ])),
                          onTap: () => Utils.launchURLInCustomeTab(context,
                              url:
                                  "https://www.iubenda.com/privacy-policy/83133872/legal")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: InkWell(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "UKHESHE Terms and Conditions",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue))
                          ])),
                          onTap: () => Utils.launchURLInCustomeTab(context,
                              url:
                                  "https://www.ukheshe.co.za/terms-and-conditions")),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 16, bottom: 16),
                        child: Builder(
                            builder: (context) =>
                                FloatingActionButtonWithProgress(
                                  viewModel: viewModel.progressMv,
                                  onPressed: () {
                                    if (viewModel.allFieldsValid) {
                                      viewModel.startRegistration();
                                      showMessageDialog(context,
                                          title: "Confirm Code",
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(padding: EdgeInsets.only(bottom: 16)),
                                                IjudiInputField(
                                                  hint: "OTP",
                                                  autofillHints: [
                                                    AutofillHints.oneTimeCode
                                                  ],
                                                  type: TextInputType.number,
                                                  color: IjudiColors.color5,
                                                  onChanged: (value) =>
                                                      viewModel.otp = value,
                                                )
                                              ]),
                                          actionName: "Proceed",
                                          action: () =>
                                              viewModel.registerUser());
                                    } else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          backgroundColor: IjudiColors.color2,
                                          content: Text(
                                              'Some fields are missing or invalid.')));
                                    }
                                  },
                                  child: Icon(Icons.check),
                                )))
                  ],
                ))
          ],
        ));
  }
}
