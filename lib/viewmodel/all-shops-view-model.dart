import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/view/all-shops-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class AllShopsViewModel extends BaseViewModel<AllShopsView> {

  List<Shop> _shops = [];
  List<Shop> get shops => _shops;

    @override
  void initialize() {
   _shops = fetchAllShops();
  }

  addShop(Shop shop) {
    _shops.add(shop);
    setState(() {});
  }

  fetchAllShops() => ApiService.findAllShopByLocation();

}