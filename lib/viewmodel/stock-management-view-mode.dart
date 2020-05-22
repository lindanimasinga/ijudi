import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class StockManagementViewModel extends BaseViewModel {

  final Shop shop;

  String newItemName;
  String newItemPrice;
  String newItemQuantity;

  StockManagementViewModel(this.shop);

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
          notifyChanged();
        }, onDone: () {
          progressMv.isBusy = false;
        });
  }
  
}