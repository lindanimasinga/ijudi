import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StockManagementViewModel extends BaseViewModel {

  final Shop shop;
  List<Stock> _stocks;

  String newItemName;
  String newItemPrice;
  String newItemQuantity;

  StockManagementViewModel(this.shop);

  @override
  initialize() {
   ApiService.findAllStockByShopId(shop.id)
    .asStream()
    .listen((resp) {
        stocks = resp;
      }, onDone: () {
      
      });  
  }

  addNewItem() {
    progressMv.isBusy = true;
    var stock = Stock(
      name: newItemName,
      price: newItemPrice,
      quantity: newItemQuantity);
      
    ApiService.addStockItem(shop.id, stock)
        .asStream()
        .listen((event) { 
          newItemName = "";
          newItemQuantity = "";
          newItemPrice = "";
          stocks.add(stock);
          notifyChanged();
        }, onDone: () {
          progressMv.isBusy = false;
        });
  }

  List<Stock> get stocks => _stocks;
  set stocks(List<Stock> stocks) {
    _stocks = stocks;
    notifyChanged();
  }
  
}