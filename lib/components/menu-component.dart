import 'package:flutter/material.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/profile-view.dart';

class MenuComponent extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Stack(
          children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Buttons.menu(
                        children: <Widget> [
                          Buttons.menuItem(
                            text : "Shop", color: IjudiColors.color1, isFirst: true,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "Profile", color: IjudiColors.color2,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, ProfileView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "My Shops", color: IjudiColors.color3,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, MyShopsView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "Errands", color: IjudiColors.color4),
                          Buttons.menuItem(text: "Settings", color: IjudiColors.color5, isLast: true,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, AllComponentsView.ROUTE_NAME, (Route<dynamic> route) => false))
                        ]
                      ),
                Padding(padding: EdgeInsets.all(30)),      
                Buttons.accountFlat(text: "Logout", action: () => Navigator.pushNamedAndRemoveUntil(context, LoginView.ROUTE_NAME, (Route<dynamic> route) => false))    
                ]
              )
      ]);
  }
}