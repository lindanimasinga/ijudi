import 'package:flutter/material.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/view/personal-and-bank.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/view/start-shopping.dart';
import 'package:ijudi/viewmodel/all-shops-view-model.dart';
import 'package:ijudi/viewmodel/delivery-option-view-model.dart';
import 'package:ijudi/viewmodel/final-order-view-model.dart';
import 'package:ijudi/viewmodel/login-view-model.dart';
import 'package:ijudi/viewmodel/my-shops-view-model.dart';
import 'package:ijudi/viewmodel/payment-view-model.dart';
import 'package:ijudi/viewmodel/register-view-model.dart';
import 'package:ijudi/viewmodel/start-shopping-view-model.dart';

class NavigatorService {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    var viewmodel;
    switch (settings.name) {
      case LoginView.ROUTE_NAME:
        viewmodel = LoginViewModel();
        return MaterialPageRoute(builder: (context) => LoginView(viewModel: viewmodel));
      case RegisterView.ROUTE_NAME:
        viewmodel = RegisterViewModel();
        return MaterialPageRoute(builder: (context) => RegisterView(viewModel: viewmodel));
      case AllShopsView.ROUTE_NAME:
        viewmodel = AllShopsViewModel();
        return MaterialPageRoute(builder: (context) => AllShopsView(viewModel: viewmodel));
      case AllComponentsView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => AllComponentsView());
      case ProfileView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => ProfileView());
      case PersonalAndBankView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => PersonalAndBankView());
      case MyShopsView.ROUTE_NAME:
        viewmodel = MyShopsViewModel();
        return MaterialPageRoute(builder: (context) => MyShopsView(viewModel: viewmodel));
      case StartShoppingView.ROUTE_NAME:
        viewmodel = StartShoppingViewModel(args);
        return MaterialPageRoute(builder: (context) => StartShoppingView(viewModel: viewmodel));
      case DeliveryOptionsView.ROUTE_NAME:
        viewmodel = DeliveryOptionsViewModel(args);
        return MaterialPageRoute(builder: (context) => DeliveryOptionsView(viewModel: viewmodel));  
      case PaymentView.ROUTE_NAME:
        viewmodel = PaymentViewModel(args);
        return MaterialPageRoute(builder: (context) => PaymentView(viewModel: viewmodel)); 
      case FinalOrderView.ROUTE_NAME:
        viewmodel = FinalOrderViewModel(args);
        return MaterialPageRoute(builder: (context) => FinalOrderView(viewModel: viewmodel));    
      default : return MaterialPageRoute(builder: (context) => LoginView());
    }
  }
}
