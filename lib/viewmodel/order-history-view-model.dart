import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class OrderHistoryViewModel extends BaseViewModel {
  List<Order> _orders = [];

  @override
  void initialize() {
    ApiService.findOrdersByCustomerId("").asStream().listen((respo) {
      orders = respo;
    }, onDone: () {
    });
  }

  List<Order> get orders => _orders;

  set orders(List<Order> orders) {
    _orders = orders;
    notifyChanged();
  }
}
