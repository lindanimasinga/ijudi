import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-form.dart';
import 'package:ijudi/components/ijudi-login-field.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/register-view.dart';

class LoginView extends StatelessWidget {
  static const String ROUTE_NAME = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: IjudiColors.color1,
          elevation: 0,
          title: Text("Login", style: TextStyle(color: Colors.white)),
        ),
        body: Stack(children: <Widget>[
          Headers.getHeader(context),
          Center(
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
                                  icon: Icon(Icons.phone_android,
                                      size: 22,
                                      color: Colors.white),
                                  type: TextInputType.phone,
                                  color: IjudiColors.color5),
                              IjudiLoginField(
                                hint: "Password",
                                icon: Icon(Icons.lock,
                                      size: 22,
                                      color: Colors.white),
                                type: TextInputType.visiblePassword,
                                color: IjudiColors.color5,
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        FloatingActionButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, 
                                                AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false),
                          child: Icon(Icons.arrow_forward),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Text("Sign in With"),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Buttons.google(), Buttons.facebook()],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 32)),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Buttons.account(
                                text: "Register",
                                action: () => Navigator.pushNamed(context, 
                                                RegisterView.ROUTE_NAME),
                    ))
              ])
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                alignment: Alignment.bottomCenter,
                child: Text("2020 All rights reserved. View our policy here"),
              )
        ]));
  }
}
