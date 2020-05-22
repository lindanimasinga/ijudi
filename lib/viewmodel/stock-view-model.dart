import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StockViewModel extends BaseViewModel{

  List<Stock> _stock;
  final Shop shop;

  StockViewModel(this.shop);

  List<Stock> get stock => _stock;
  set stock(List<Stock> value) {
    _stock = value;
    notifyChanged();
  }

  @override
  void initialize() {
    //progressMv.isBusy = true;
    ApiService.findAllStockByShopId(shop.id)
    .asStream()
    .listen(
      (resp) {
        stock = resp;
      }, onDone: () {
        //progressMv.isBusy = false;
      });
  }

  Stock getStockByName(String name) => _stock.firstWhere((item) => item.name == name);
}