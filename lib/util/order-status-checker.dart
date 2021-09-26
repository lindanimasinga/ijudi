import 'dart:async';

import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';

mixin OrderStatusChecker {
  late Timer _timer;
  late ApiService apiService;
  List<Order>? orders;

  Order? get currentOrder => null;

  startOrderStatusCheck() {
    _timer = Timer.periodic(Duration(seconds: 10), (time) {
      apiService.findOrderById(currentOrder?.id).asStream().listen((respo) {
        currentOrder?.stage = respo.stage;
        notifyChanged();
      }, onError: (e) {
        showError(error: e);
      }, onDone: () {});
    });
  }

  startOrdersStatusCheck({String? storeId, String? messengerId, String? userId}) {
    _timer = Timer.periodic(Duration(seconds: 10), (time) {
      Future<List<Order>> orderStream = userId != null
          ? apiService.findOrdersByPhoneNumber(userId)
          : messengerId != null
              ? apiService.findOrdersByMessengerId(messengerId)
              : storeId != null
                  ? apiService.findOrdersByShopId(storeId)
                  : Future.value([]);

    orderStream.asStream().listen((respo) {
        orders = respo;
      }, onError: (e) {
        showError(error: e);
      }, onDone: () {});
    });
  }

  showError({dynamic error});

  notifyChanged();

  void destroy() {
    _timer.cancel();
  }

}
