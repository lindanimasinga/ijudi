
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/services/local-notification-service.dart';
import 'package:ijudi/util/order-status-checker.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FinalOrderViewModel extends BaseViewModel with OrderStatusChecker {
  Order? currentOrder;

  final ApiService apiService;
  final NotificationService? localNotificationService;

  FinalOrderViewModel(
      {required this.currentOrder,
      required this.apiService,
      required this.localNotificationService});

  @override
  void initialize() {
    if (currentOrder!.shop != null) {
      var dateTime = DateTime.now().add(Duration(minutes: 10));
      localNotificationService!
          .scheduleLocalMessage(dateTime, "${currentOrder!.shop!.name}",
              "Dont forget about your order. Please check progress in the app.")
          .asStream()
          .listen((event) {});

      dateTime = DateTime.now().add(Duration(minutes: 20));
      localNotificationService!
          .scheduleLocalMessage(dateTime, "${currentOrder!.shop!.name}",
              "Dont forget about your order. Please check progress in the app.")
          .asStream()
          .listen((event) {});
    }

    if (currentOrder!.shop == null) {
      apiService
          .findShopById(currentOrder!.shopId)
          .asStream()
          .listen((shp) => shop = shp, onError: (e) {
        showError(error: e);
      });
    }

    startOrderStatusCheck();
  }

  Shop? get shop => currentOrder!.shop;
  set shop(Shop? shop) {
    currentOrder!.shop = shop;
    notifyChanged();
  }

  OrderStage? get currentStage => currentOrder!.stage;
  set currentStage(OrderStage? stage) {
    currentOrder!.stage = stage;
    notifyChanged();
  }

  OrderStage? get stage => currentOrder!.stage;

  @override
  void dispose() {
    super.dispose();
    super.destroy();
  }
}
