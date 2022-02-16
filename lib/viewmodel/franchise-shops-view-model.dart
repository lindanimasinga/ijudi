
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FranchiseShopsViewModel extends BaseViewModel {

  List<Shop> shops;

  FranchiseShopsViewModel({required this.shops});

  @override
  void initialize() {}

  addShop(Shop shop) {
    shops.add(shop);
    notifyChanged();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
