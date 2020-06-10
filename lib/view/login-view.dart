import 'package:flutter/material.dart';
import 'package:ijudi/components/floating-action-button-with-progress.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-login-field.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/scrollable-parent-container.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/login-view-model.dart';

class LoginView extends MvStatefulWidget<LoginViewModel> {
  
  static const String ROUTE_NAME = "/";

  LoginView({LoginViewModel viewModel}) : super(viewModel);

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
                                  hint: "Cell Number",
                                  type: TextInputType.phone,
                                  icon: Icon(Icons.phone_android,
                                      size: 22,
                                      color: Colors.white),
                                  onTap: (number) => viewModel.username = number,
                                  color: IjudiColors.color5),
                              IjudiLoginField(
                                hint: "Password",
                                icon: Icon(Icons.lock,
                                      size: 22,
                                      color: Colors.white,),
                                isPassword: true,
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
                        Buttons.iconButton(Icon(Icons.settings), color: IjudiColors.color4),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Buttons.iconButton(Icon(Icons.chat), color: IjudiColors.color2)
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Buttons.account( 
                                text: "Register",
                                action: () => viewModel.register(),
                              )
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8, top: 32),
                      alignment: Alignment.bottomCenter,
                      child: Text("2020 All rights reserved. View our policy here", style: IjudiStyles.SUBTITLE_2),
                    )
              ])
              )
        ]));
  }
}
