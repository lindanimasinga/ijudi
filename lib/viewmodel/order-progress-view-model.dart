import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/viewmodel/final-order-view-model.dart';

class OrderProgressViewModel extends BaseViewModel {
  final Order order;
  final OrderStage stage;
  final String label;

  final LOTTIE_BY_STAGE = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "assets/lottie/loading.json",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: "assets/lottie/loading.json",
    OrderStage.STAGE_2_STORE_PROCESSING: "assets/lottie/packing.json",
    OrderStage.STAGE_3_READY_FOR_COLLECTION: "assets/lottie/food.json",
    OrderStage.STAGE_4_ON_THE_ROAD: "assets/lottie/delivery.json",
    OrderStage.STAGE_5_ARRIVED: "assets/lottie/loading.json",
    OrderStage.STAGE_6_WITH_CUSTOMER: "assets/lottie/food.json"
  };

  final onlineDeliveryStages = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID: 0,
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM: 1,
    OrderStage.STAGE_2_STORE_PROCESSING: 2,
    OrderStage.STAGE_3_READY_FOR_COLLECTION: 3,
    OrderStage.STAGE_4_ON_THE_ROAD: 4,
    OrderStage.STAGE_5_ARRIVED: 5,
    OrderStage.STAGE_6_WITH_CUSTOMER: 6,
    OrderStage.STAGE_7_ALL_PAID: 7
  };

  get messageMap => {
        OrderStage.STAGE_0_CUSTOMER_NOT_PAID: "assets/lottie/loading.json",
        OrderStage.STAGE_1_WAITING_STORE_CONFIRM:
            "Waiting for shop ${shop.name} to accept your order. This may take a few minutes.",
        OrderStage.STAGE_2_STORE_PROCESSING:
            "${shop.name} is now processing your order",
        OrderStage.STAGE_3_READY_FOR_COLLECTION:
            "The driver is now collecting your. Brace yourself..",
        OrderStage.STAGE_4_ON_THE_ROAD: "The driver is on his way",
        OrderStage.STAGE_5_ARRIVED:
            "The driver has arrived. Please come collect.",
        OrderStage.STAGE_6_WITH_CUSTOMER:
            "You have received your order, Give us a review."
      };

  OrderProgressViewModel({this.order, this.stage, this.label = ""});

  get isCurrentStage => order.stage == stage;

  OrderStage get currentStage => order.stage;

  Shop get shop => order.shop == null ? Utils.createPlaceHolder() : order.shop;

  bool get isCompleted =>
      onlineDeliveryStages[stage] < onlineDeliveryStages[currentStage];
}
