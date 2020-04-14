import 'package:flutter/material.dart';
import 'package:ijudi/util/navigator-service.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/shop.dart';

class MenuView extends StatelessWidget {

  static const ROUTE_NAME = "menu";
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(),
        body: Column( 
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Buttons.menu(
                children: <Widget> [
                  Buttons.menuItem(
                    text : "Shop", color: IjudiColors.color1, isFirst: true,
                    action : () => Navigator.pushNamed(context, ShoppingView.ROUTE_NAME)),
                  Buttons.menuItem(text: "Profile", color: IjudiColors.color2,
                    action : () => Navigator.pushNamed(context, ProfileView.ROUTE_NAME)),
                  Buttons.menuItem(text: "My Shops", color: IjudiColors.color3),
                  Buttons.menuItem(text: "Errands", color: IjudiColors.color4),
                  Buttons.menuItem(text: "Settings", color: IjudiColors.color5, isLast: true,
                    action : () => Navigator.pushNamed(context, AllComponents.ROUTE_NAME))
                ]
              ),
          Buttons.account(text: "Logout")    
      ])
    );
  }
}