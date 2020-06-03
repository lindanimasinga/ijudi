import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/order-history-view.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/view/personal-and-bank.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/quick-pay.dart';
import 'package:ijudi/view/quick-payment-success.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/view/start-shopping.dart';
import 'package:ijudi/view/stock-view.dart';
import 'package:ijudi/view/wallet-view.dart';
import 'package:ijudi/viewmodel/all-shops-view-model.dart';
import 'package:ijudi/viewmodel/delivery-option-view-model.dart';
import 'package:ijudi/viewmodel/final-order-view-model.dart';
import 'package:ijudi/viewmodel/login-view-model.dart';
import 'package:ijudi/viewmodel/my-shops-view-model.dart';
import 'package:ijudi/viewmodel/order-history-view-model.dart';
import 'package:ijudi/viewmodel/payment-view-model.dart';
import 'package:ijudi/viewmodel/profile-view-model.dart';
import 'package:ijudi/viewmodel/quick-pay-view-model.dart';
import 'package:ijudi/viewmodel/register-view-model.dart';
import 'package:ijudi/viewmodel/start-shopping-view-model.dart';
import 'package:ijudi/viewmodel/stock-management-view-mode.dart';
import 'package:ijudi/viewmodel/wallet-view-model.dart';

class NavigatorService {

  final StorageManager storageManager;
  final UkhesheService ukhesheService;
  final ApiService apiService;

  NavigatorService({
    @required this.ukhesheService, 
    @required this.storageManager,
    @required this.apiService});


  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    var viewmodel;
    var routeName = settings.name == LoginView.ROUTE_NAME 
                && storageManager.isLoggedIn ? AllShopsView.ROUTE_NAME : settings.name;

    switch (routeName) {
      case LoginView.ROUTE_NAME:
        viewmodel = LoginViewModel(
          storage: storageManager, 
          ukhesheService: ukhesheService,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => LoginView(viewModel: viewmodel));
      case RegisterView.ROUTE_NAME:
        viewmodel = RegisterViewModel(
          ukhesheService : ukhesheService,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => RegisterView(viewModel: viewmodel));
      case AllShopsView.ROUTE_NAME:
        viewmodel = AllShopsViewModel(
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => AllShopsView(viewModel: viewmodel));
      case AllComponentsView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => AllComponentsView());
      case ProfileView.ROUTE_NAME:
        viewmodel = ProfileViewModel(
          ukhesheService : ukhesheService,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => ProfileView(viewModel: viewmodel));
      case PersonalAndBankView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => PersonalAndBankView(apiService: apiService,));
      case MyShopsView.ROUTE_NAME:
        viewmodel = MyShopsViewModel(
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => MyShopsView(viewModel: viewmodel));
      case StartShoppingView.ROUTE_NAME:
        viewmodel = StartShoppingViewModel(
          shop: args,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => StartShoppingView(viewModel: viewmodel));
      case DeliveryOptionsView.ROUTE_NAME:
        viewmodel = DeliveryOptionsViewModel(
          order: args, 
          ukhesheService: ukhesheService,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => DeliveryOptionsView(viewModel: viewmodel));  
      case PaymentView.ROUTE_NAME:
        viewmodel = PaymentViewModel(
          order: args, 
          ukhesheService: ukhesheService,
          apiService: apiService);
        return MaterialPageRoute(builder: (context) => PaymentView(viewModel: viewmodel)); 
      case FinalOrderView.ROUTE_NAME:
        viewmodel = FinalOrderViewModel(
          order: args,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => FinalOrderView(viewModel: viewmodel));  
      case StockManagementView.ROUTE_NAME:
        viewmodel = StockManagementViewModel(
          shop: args,
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => StockManagementView(viewModel: viewmodel));  
      case OrderHistoryView.ROUTE_NAME:
        viewmodel = OrderHistoryViewModel(
          apiService: apiService
        );
        return MaterialPageRoute(builder: (context) => OrderHistoryView(viewModel: viewmodel));          
      case WalletView.ROUTE_NAME:
        viewmodel = WalletViewModel(
          apiService: apiService,
          ukhesheService: ukhesheService
        );
        return MaterialPageRoute(builder: (context) => WalletView(viewModel: viewmodel));
      case QuickPayView.ROUTE_NAME:
        viewmodel = QuickPayViewModel(
          apiService: apiService,
          ukhesheService: ukhesheService,
          shop: args
        );
        return MaterialPageRoute(
          builder: (context) => QuickPayView(viewModel: viewmodel),
          fullscreenDialog: true
        ); 
      case QuickPaymentSuccess.ROUTE_NAME:
        return MaterialPageRoute(
          builder: (context) => QuickPaymentSuccess(order: args),
          fullscreenDialog: true
        );              
      default : return MaterialPageRoute(builder: (context) => LoginView());
    }
  }
}
