import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-login-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/login-view-model.dart';

class LoginView extends MvStatefulWidget<LoginViewModel> {
  static const String ROUTE_NAME = "/";

  Timer _timer;

  LoginView({LoginViewModel viewModel}) : super(viewModel);

  @override
  void initialize() {
    _timer = new Timer.periodic(Duration(seconds: 1), (time) {
      if(viewModel == null || time.tick == 15) {
        time.cancel();
        return;
      }
      viewModel.fingerPrintIconSise = time.tick % 2 == 0 ? 52 : 46;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableParent(
        hasDrawer: false,
        title: "Login",
        appBarColor: IjudiColors.color1,
        child: Stack(children: <Widget>[
          Headers.getHeader(context),
          Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 32)),
                    Row(
                      children: <Widget>[
                        IjudiForm(
                          child: Column(
                            children: <Widget>[
                              IjudiLoginField(
                                  hint: "SA Mobile Number",
                                  type: TextInputType.phone,
                                  text: () => viewModel.username,
                                  autofillHints: [
                                    AutofillHints.telephoneNumber,
                                    AutofillHints.telephoneNumberLocal
                                  ],
                                  icon: Icon(Icons.phone_android,
                                      size: 22, color: Colors.white),
                                  onTap: (number) =>
                                      viewModel.username = number,
                                  color: IjudiColors.color5),
                              IjudiLoginField(
                                hint: "Password",
                                text: () => viewModel.password,
                                icon: Icon(
                                  Icons.lock,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                autofillHints: [AutofillHints.newPassword],
                                onTap: (pass) => viewModel.password = pass,
                                color: IjudiColors.color5,
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        FloatingActionButtonWithProgress(
                          viewModel: viewModel.progressMv,
                          onPressed: () => viewModel.login(),
                          child: Icon(Icons.arrow_forward),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Text("Having Trouble?"),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Buttons.iconButton(
                            Icon(Icons.settings),
                            color: IjudiColors.color4,
                            onPressed: () => viewModel.forgotPassword()),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Buttons.iconButton(Icon(Icons.chat),
                            color: IjudiColors.color2)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Buttons.account(
                          text: "Register",
                          action: () => viewModel.register(),
                        )),
                    !viewModel.hasBioMetric
                        ? Container()
                        : GestureDetector(
                            onTap: () => viewModel.authenticate(),
                            child: Container(
                                height: 52,
                                width: 52,
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 16),
                                child: AnimatedSize(
                                    vsync: viewModel,
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.bounceInOut,
                                    child: Icon(
                                      Icons.fingerprint,
                                      color: IjudiColors.color1,
                                      size: viewModel.fingerPrintIconSise,
                                    )))),
                    !viewModel.hasBioMetric
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 0, top: 0),
                            child: Text("Use ${viewModel.bioMetricName}"),
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, bottom: 16, top: 16),
                      child: InkWell(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text:
                                    "2020 All rights reserved. View our policy here",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: IjudiColors.color5))
                          ])),
                          onTap: () => Utils.launchURL(context,
                              url:
                                  "https://www.iubenda.com/privacy-policy/83133872/legal")),
                    ),
                  ]))
        ]));
  }
}
