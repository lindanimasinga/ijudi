import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/supported-location.dart';
import 'package:ijudi/services/impl/shared-pref-storage-manager.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/view/all-components.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/view/choose-location-view.dart';
import 'package:ijudi/view/delivery-options.dart';
import 'package:ijudi/view/final-order-view.dart';
import 'package:ijudi/view/forgot-password-view.dart';
import 'package:ijudi/view/introduction-view.dart';
import 'package:ijudi/view/login-view.dart';
import 'package:ijudi/view/messenger-order-update.dart';
import 'package:ijudi/view/messenger-orders.dart';
import 'package:ijudi/view/my-shop-order-update.dart';
import 'package:ijudi/view/my-shop-orders.dart';
import 'package:ijudi/view/my-shops.dart';
import 'package:ijudi/view/order-history-view.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/view/payment-webview.dart';
import 'package:ijudi/view/personal-and-bank.dart';
import 'package:ijudi/view/profile-view.dart';
import 'package:ijudi/view/quick-payment-success.dart';
import 'package:ijudi/view/register-view.dart';
import 'package:ijudi/view/shop-profile-view.dart';
import 'package:ijudi/view/start-shopping.dart';
import 'package:ijudi/view/stock-add-new.dart';
import 'package:ijudi/view/stock-view.dart';
import 'package:ijudi/view/tranasction-history-view.dart';
import 'package:ijudi/viewmodel/all-shops-view-model.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/viewmodel/choose-location-viewmodel.dart';
import 'package:ijudi/viewmodel/delivery-option-view-model.dart';
import 'package:ijudi/viewmodel/final-order-view-model.dart';
import 'package:ijudi/viewmodel/forgot-password-view-model.dart';
import 'package:ijudi/viewmodel/messenger-order-update-view-model.dart';
import 'package:ijudi/viewmodel/messenger-orders-view-model.dart';
import 'package:ijudi/viewmodel/my-shop-order-update-view-model.dart';
import 'package:ijudi/viewmodel/my-shops-view-model.dart';
import 'package:ijudi/viewmodel/myshop-orders-view-model.dart';
import 'package:ijudi/viewmodel/order-history-view-model.dart';
import 'package:ijudi/viewmodel/payment-view-model.dart';
import 'package:ijudi/viewmodel/profile-view-model.dart';
import 'package:ijudi/viewmodel/receipt-view-model.dart';
import 'package:ijudi/viewmodel/register-view-model.dart';
import 'package:ijudi/viewmodel/shop-profile-view-model.dart';
import 'package:ijudi/viewmodel/start-shopping-view-model.dart';
import 'package:ijudi/viewmodel/stock-add-new-view-model.dart';
import 'package:ijudi/viewmodel/stock-management-view-mode.dart';

class NavigatorService {
  final SharedPrefStorageManager? sharedPrefStorageManager;
  final StorageManager? storageManager;
  final ApiService apiService;
  final NotificationService? localNotificationService;

  NavigatorService(
      {required this.storageManager,
      required this.apiService,
      required this.sharedPrefStorageManager,
      this.localNotificationService});

  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    var viewmodel;
    var routeName = settings.name;
    /*if (settings.name == IntroductionView.ROUTE_NAME &&
        sharedPrefStorageManager!.viewedIntro) {
      routeName = AllShopsView.ROUTE_NAME;
    }*/

    if (routeName == AllShopsView.ROUTE_NAME) {
      print("args is $args");
      if (args == null) {
        var geocord = sharedPrefStorageManager!.selectedLocation?.split(":");
        if (geocord == null || geocord.length < 4) {
          routeName = ChooseLocationView.ROUTE_NAME;
        } else {
          args = SupportedLocation(
              geocord[2],geocord[3], double.parse(geocord[0]), double.parse(geocord[1]));
        }
      } else {
        sharedPrefStorageManager!.selectedLocation =
            "${(args as SupportedLocation).latitude}:${args.longitude}:${args.name}:${args.region}";
      }
    }

    BaseViewModel.analytics.setCurrentScreen(screenName: settings.name);

    switch (routeName) {
      case IntroductionView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => IntroductionView());
      case ChooseLocationView.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (context) => ChooseLocationView(ChooseLocationViewModel()),
            fullscreenDialog: true);
      case LoginView.ROUTE_NAME:
      /*viewmodel = LoginViewModel(
            sharedPrefs: sharedPrefStorageManager,
            storage: storageManager,
            ukhesheService: ukhesheService,
            apiService: apiService,
            notificationService: localNotificationService);
        return MaterialPageRoute(
            builder: (context) => LoginView(viewModel: viewmodel),
            fullscreenDialog: true);*/
      case RegisterView.ROUTE_NAME:
        viewmodel = RegisterViewModel(
            apiService: apiService,
            notificationService: localNotificationService,
            storage: storageManager,
            address: args as String?);
        return MaterialPageRoute(
            builder: (context) => RegisterView(viewModel: viewmodel),
            fullscreenDialog: true);
      case ForgotPasswordView.ROUTE_NAME:
        viewmodel = ForgotPasswordViewModel(
            storageManager: storageManager, apiService: apiService);
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ForgotPasswordView(viewModel: viewmodel));
      case AllShopsView.ROUTE_NAME:
        viewmodel = AllShopsViewModel(
            apiService: apiService,
            storageManager: storageManager,
            supportedLocation: args as SupportedLocation?);
        return MaterialPageRoute(
            builder: (context) => AllShopsView(viewModel: viewmodel));
      case AllComponentsView.ROUTE_NAME:
        return MaterialPageRoute(builder: (context) => AllComponentsView());
      case ProfileView.ROUTE_NAME:
        viewmodel = ProfileViewModel(apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => ProfileView(viewModel: viewmodel));
      case PersonalAndBankView.ROUTE_NAME:
        return MaterialPageRoute(
            builder: (context) => PersonalAndBankView(
                  apiService: apiService,
                ));
      case MyShopsView.ROUTE_NAME:
        viewmodel = MyShopsViewModel(apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => MyShopsView(viewModel: viewmodel));
      case ShopProfileView.ROUTE_NAME:
        viewmodel =
            ShopProfileViewModel(apiService: apiService, shop: args as Shop?);
        return MaterialPageRoute(
            builder: (context) => ShopProfileView(viewModel: viewmodel));
      case StartShoppingView.ROUTE_NAME:
        viewmodel =
            StartShoppingViewModel(shop: args as Shop?, apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => StartShoppingView(viewModel: viewmodel));
      case DeliveryOptionsView.ROUTE_NAME:
        viewmodel = DeliveryOptionsViewModel(
            order: args as Order?,
            apiService: apiService,
            storageManager: storageManager);
        return MaterialPageRoute(
            builder: (context) => DeliveryOptionsView(viewModel: viewmodel));
      case PaymentView.ROUTE_NAME:
        viewmodel =
            PaymentViewModel(order: args as Order?, apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => PaymentView(viewModel: viewmodel));
      case PaymentWebView.ROUTE_NAME:
        var url = (args as List).first;
        var onDone = args.last;
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PaymentWebView(url: url, doneAction: onDone));
      case FinalOrderView.ROUTE_NAME:
        viewmodel = FinalOrderViewModel(
            currentOrder: args as Order?,
            apiService: apiService,
            localNotificationService: localNotificationService);
        return MaterialPageRoute(
            builder: (context) => FinalOrderView(viewModel: viewmodel));
      case StockManagementView.ROUTE_NAME:
        viewmodel = StockManagementViewModel(
            shop: args as Shop?, apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => StockManagementView(viewModel: viewmodel));
      case StockAddNewView.ROUTE_NAME:
        viewmodel = StockAddNewViewModel(
            inputData: args as StockAddNewInput?, apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => StockAddNewView(viewModel: viewmodel),
            fullscreenDialog: true);
      case OrderHistoryView.ROUTE_NAME:
        viewmodel = OrderHistoryViewModel(apiService: apiService);
        return MaterialPageRoute(
            builder: (context) => OrderHistoryView(viewModel: viewmodel));
      case MyShopOrdersView.ROUTE_NAME:
        viewmodel = MyShopOrdersViewModel(
            apiService: apiService, shopId: args as String?);
        return MaterialPageRoute(
            builder: (context) => MyShopOrdersView(viewModel: viewmodel));
      case MessengerOrdersView.ROUTE_NAME:
        viewmodel = MessengerOrdersViewModel(
            apiService: apiService, messengerId: args as String?);
        return MaterialPageRoute(
            builder: (context) => MessengerOrdersView(viewModel: viewmodel));
      case MyShopOrderUpdateView.ROUTE_NAME:
        viewmodel = MyShopOrderUpdateViewModel(
            apiService: apiService, order: args as Order?);
        return MaterialPageRoute(
            builder: (context) => MyShopOrderUpdateView(viewModel: viewmodel));
      case MessengerOrderUpdateView.ROUTE_NAME:
        viewmodel = MessengerOrderUpdateViewModel(
            apiService: apiService, order: args as Order?);
        return MaterialPageRoute(
            builder: (context) =>
                MessengerOrderUpdateView(viewModel: viewmodel));
      case ReceiptView.ROUTE_NAME:
        viewmodel =
            ReceiptViewModel(apiService: apiService, order: args as Order?);
        return MaterialPageRoute(
            builder: (context) => ReceiptView(viewModel: viewmodel),
            fullscreenDialog: true);
      default:
        viewmodel = AllShopsViewModel(
            apiService: apiService,
            storageManager: storageManager,
            supportedLocation: args as SupportedLocation?);
        return MaterialPageRoute(
            builder: (context) => AllShopsView(viewModel: viewmodel));
    }
  }
}
