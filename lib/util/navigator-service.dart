import 'package:flutter/material.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/menu-view.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/shop.dart';

class NavigatorService {


  static Map<String, WidgetBuilder> getNavigationRoute() {
    return {
          '/': (context) => MenuView(),
          AllComponents.ROUTE_NAME: (context) => AllComponents(),
          ShoppingView.ROUTE_NAME: (context) => ShoppingView(),
          ProfileView.ROUTE_NAME: (context) => ProfileView(),
        };
  }
}