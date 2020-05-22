import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FinalOrderViewModel extends BaseViewModel {
  
  final Order order;

  var shop;

  FinalOrderViewModel(this.order);

  @override
  void initialize() {
    shop = ApiService.findShopById("s");
  }
  
  void moveNextStage() {
    order.moveNextStage();
    notifyChanged();
  }

  int get stage => order.stage;

  

}
