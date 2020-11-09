import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/services/impl/secure-storage-manager.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/util/message-dialogs.dart';
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

class _MenuComponentState extends State<MenuComponent>
    with AutomaticKeepAliveClientMixin, MessageDialogs {
  StorageManager _storageManager;
  ProfileRoles _profileRole = ProfileRoles.CUSTOMER;
  String _userId;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SecureStorageManager.singleton().then((value) {
      _storageManager = value;
      profileRole = _storageManager.profileRole;
      _userId = _storageManager.getIjudiUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    double buttonHeight = deviceWidth > 360 ? 70 : 60;
    log("device width is $deviceWidth");
    return Stack(children: <Widget>[
      Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Buttons.menu(children: <Widget>[
                profileRole != ProfileRoles.MESSENGER
                    ? Container()
                    : Buttons.menuItem(
                        text: "Collections",
                        height: buttonHeight,
                        action: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            MessengerOrdersView.ROUTE_NAME,
                            (Route<dynamic> route) => false,
                            arguments: _userId)),
                Buttons.menuItem(
                    text: "Shopping",
                    height: buttonHeight,
                    action: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        AllShopsView.ROUTE_NAME,
                        (Route<dynamic> route) => false)),
                Buttons.menuItem(
                    text: "My Wallet",
                    height: buttonHeight,
                    action: !isLoggedIn
                        ? () => showLoginMessage(context,
                            onLogin: () => Navigator.pop(context))
                        : () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            WalletView.ROUTE_NAME,
                            (Route<dynamic> route) => false)),
                !isLoggedIn
                    ? Container()
                    : Buttons.menuItem(
                        text: "Orders",
                        height: buttonHeight,
                        action: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            OrderHistoryView.ROUTE_NAME,
                            (Route<dynamic> route) => false)),
                profileRole != ProfileRoles.STORE_ADMIN
                    ? Container()
                    : Buttons.menuItem(
                        text: "My Shop",
                        height: buttonHeight,
                        action: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            MyShopsView.ROUTE_NAME,
                            (Route<dynamic> route) => false)),
                !isLoggedIn
                    ? Container()
                    : Buttons.menuItem(
                        text: "Profile",
                        height: buttonHeight,
                        action: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            ProfileView.ROUTE_NAME,
                            (Route<dynamic> route) => false)),
                /*  Buttons.menuItem(
                                                    text: "Settings",
                                                    height: buttonHeight,
                                                    action : () => Navigator.pushNamedAndRemoveUntil(context, AllComponentsView.ROUTE_NAME, (Route<dynamic> route) => false))
                                                */
              ]),
              isLoggedIn
                  ? Buttons.accountFlat(
                      text: "Logout",
                      action: () {
                        _storageManager.clear().listen((event) {
                          log("logged out");
                          BaseViewModel.analytics
                              .logEvent(name: "logout")
                              .then((value) => {});
                          Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false);
                        });
                      })
                  : Buttons.accountFlat(
                      text: "Login",
                      action: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, LoginView.ROUTE_NAME);
                      })
            ]),
      ),
      Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: deviceWidth > 360 ? 70 : 50),
          child: Image.asset("assets/images/izinga-logo.png", width: 100)),
      Headers.getMenuHeader(context),
    ]);
  }

  ProfileRoles get profileRole => _profileRole;
  set profileRole(ProfileRoles profileRole) {
    _profileRole = profileRole;
    setState(() {});
  }

  get isLoggedIn => _storageManager != null && _storageManager.isLoggedIn;
}
