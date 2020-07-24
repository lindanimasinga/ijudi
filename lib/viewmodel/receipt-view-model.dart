import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class ReceiptViewModel extends BaseViewModel {

  Shop _shop = Utils.createPlaceHolder();
  final Order order;
  final ApiService apiService;

  ReceiptViewModel({this.apiService, this.order});

  @override
  initialize() {
    if(order.shop == null) {
      apiService.findShopById(order.shopId).asStream()
      .listen((data) { 
        shop = data;
      }, onError: (e) {
          showError(error: e);
      });
      return;
    }
    shop = order.shop;
  }

  Shop get shop => _shop;
  set shop(Shop shop) {
    _shop = shop;
    notifyChanged();
  }
}