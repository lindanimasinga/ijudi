import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/services/impl/secure-storage-manager.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/view/messenger-orders.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/order-history-view.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/wallet-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MenuComponent extends StatefulWidget {

   @override
  _MenuComponentState createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> with AutomaticKeepAliveClientMixin{
  
  StorageManager _storageManager;
  ProfileRoles _profileRole = ProfileRoles.CUSTOMER;
  String _userId;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    SecureStorageManager.singleton()
    .then((value) {
      _storageManager = value;
      profileRole = _storageManager.profileRole;
      _userId = _storageManager.getIjudiUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    double buttonHeight = deviceWidth >= 360 ? 70 : 60;

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
                          profileRole != ProfileRoles.MESSENGER ? Container() : Buttons.menuItem(
                            text: "Collections",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, 
                              MessengerOrdersView.ROUTE_NAME, (Route<dynamic> route) => false, arguments: _userId)),
                          Buttons.menuItem(
                            text : "Shop",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(
                            text: "Wallet",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, WalletView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(
                            text: "Orders",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, OrderHistoryView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          profileRole != ProfileRoles.STORE_ADMIN ? Container() : Buttons.menuItem(
                            text: "My Shop & Orders",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, MyShopsView.ROUTE_NAME, (Route<dynamic> route) => false)),
                          Buttons.menuItem(
                            text: "Profile",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, ProfileView.ROUTE_NAME, (Route<dynamic> route) => false)),
                       /*  Buttons.menuItem(
                            text: "Settings",
                            height: buttonHeight,
                            action : () => Navigator.pushNamedAndRemoveUntil(context, AllComponentsView.ROUTE_NAME, (Route<dynamic> route) => false))
                        */]
                      ),      
                Buttons.accountFlat(text: "Logout", action: () {
                  SecureStorageManager.singleton()
                    .then((v) {
                      v.clear().listen((event) {
                        log("logged out");
                        BaseViewModel.analytics.logEvent(name: "logout").then((value) => {});
                        Navigator.pushNamedAndRemoveUntil(context, 
                        LoginView.ROUTE_NAME, 
                        (Route<dynamic> route) => false);
                      });
                  });
                }),    
                ]
              ),),
              Headers.getMenuHeader(context),
      ]);
  }

  ProfileRoles get profileRole => _profileRole;
  set profileRole(ProfileRoles profileRole) {
    _profileRole = profileRole;
    setState(() {});
  }
}