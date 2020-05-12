import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class MyShopsViewModel extends BaseViewModel {
  
  Shop _shop = Shop();

  Shop get shop => _shop;
  set shop(Shop shop) {
    _shop = shop;
    notifyChanged();
  }

  @override
  void initialize() {
    shop = ApiService.findShopById("idfromotherscreen");
  }

}