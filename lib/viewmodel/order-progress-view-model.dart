import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class OrderProgressViewModel extends BaseViewModel {
  final Order order;
  final OrderStage stage;
  final String label;

  OrderProgressViewModel({this.order, this.stage, this.label = ""});

  get isCurrentStage => order.stage == stage;

  OrderStage get currentStage => order.stage;

  Shop get shop => order.shop == null ? Utils.createPlaceHolder() : order.shop;

  bool get isCompleted =>
      Utils.onlineDeliveryStages[stage] < Utils.onlineDeliveryStages[currentStage];

  get messageMap => Utils.messageMap(shop);
}
