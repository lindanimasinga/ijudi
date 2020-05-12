import 'package:ijudi/model/order.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FinalOrderViewModel extends BaseViewModel {
  
  final Order order;

  FinalOrderViewModel(this.order);

  void moveNextStage() {
    order.moveNextStage();
    notifyChanged();
  }

  int get stage => order.stage;

  

}
