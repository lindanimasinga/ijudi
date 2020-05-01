import 'package:flutter/material.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/personal-and-bank.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/start-shopping.dart';

class NavigatorService {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case AllShopsView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => AllShopsView());
      case AllComponentsView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => AllComponentsView());
      case ProfileView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => ProfileView());
      case PersonalAndBankView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => PersonalAndBankView());
      case MyShopsView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => MyShopsView());
      case StartShoppingView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => StartShoppingView(shop: args));
      case DeliveryOptions.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => DeliveryOptions(busket: args));  
      default : return MaterialPageRoute(builder: (context) => AllShopsView());
    }
  }
}
