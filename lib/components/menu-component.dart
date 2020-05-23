import 'package:flutter/material.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/order-history-view.dart';
import 'package:ijudi/view/profile-view.dart';

class MenuComponent extends StatelessWidget {

  const MenuComponent();
  
  @override
  Widget build(BuildContext context) {

    return Stack(
          children: <Widget>[
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Buttons.menu(
                        children: <Widget> [
                          Buttons.menuItem(
                            text : "Shop",
                            action : () => Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "Profile",
                            action : () => Navigator.pushNamedAndRemoveUntil(context, ProfileView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "My Shop",
                            action : () => Navigator.pushNamedAndRemoveUntil(context, MyShopsView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "Wallet"),
                          Buttons.menuItem(text: "Orders",
                            action : () => Navigator.pushNamedAndRemoveUntil(context, OrderHistoryView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(text: "Settings",
                            action : () => Navigator.pushNamedAndRemoveUntil(context, AllComponentsView.ROUTE_NAME, (Route<dynamic> route) => false))
                        ]
                      ),      
                Buttons.accountFlat(text: "Logout", action: () {
                  SharedPrefStorageManager.singleton()
                    .then((v) {
                      v.clear();
                      Navigator.pushNamedAndRemoveUntil(context, 
                    LoginView.ROUTE_NAME, 
                    (Route<dynamic> route) => false);
                  });
                }),    
                ]
              ),),
              Headers.getMenuHeader(context),
      ]);
  }
}