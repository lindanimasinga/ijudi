import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/order-progress-view-model.dart';
import 'package:lottie/lottie.dart';

class OrderProgressStageComponent
    extends MvStatefulWidget<OrderProgressViewModel> {
  
  static const LOTTIE_BY_STAGE = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID : "assets/lottie/loading.json",
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM : "assets/lottie/packing.json",
    OrderStage.STAGE_2_STORE_PROCESSING : "assets/lottie/delivery.json",
    OrderStage.STAGE_3_READY_FOR_COLLECTION : "assets/lottie/food.json",
    OrderStage.STAGE_4_ON_THE_ROAD : "assets/lottie/done.json"
  };

  static const onlineDeliveryStages = {
    OrderStage.STAGE_0_CUSTOMER_NOT_PAID : 0,
    OrderStage.STAGE_1_WAITING_STORE_CONFIRM : 1,
    OrderStage.STAGE_2_STORE_PROCESSING : 2,
    OrderStage.STAGE_3_READY_FOR_COLLECTION : 3,
    OrderStage.STAGE_4_ON_THE_ROAD : 4,
    OrderStage.STAGE_5_ARRIVED : 5,
    OrderStage.STAGE_6_WITH_CUSTOMER : 6,
    OrderStage.STAGE_7_PAID_SHOP : 7
  };

  final String text;
  String label;

  OrderProgressStageComponent(
      {@required OrderProgressViewModel viewModel,
      this.text = "",
      this.label = ""})
      : super(viewModel);

  @override
  Widget build(BuildContext context) {
    if(viewModel.shouldStartCounting){
      viewModel.startCounting();
    }

    int xValue = onlineDeliveryStages[viewModel.stage] - onlineDeliveryStages[viewModel.currentStage];      
    double cardWidth = (-(44/3) * pow(xValue, 2)) + 352.0;
    double elevation = ((-0.5 * pow(xValue, 2)) + 5.0).abs();
    bool isDone =  onlineDeliveryStages[viewModel.stage] < onlineDeliveryStages[viewModel.currentStage];    
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(bottom: 8, left: 16),
          child: Text(label, style: IjudiStyles.HEADER_TEXT),
        ),
        IJudiCard(
            elevation: elevation,
            color: viewModel.stage == viewModel.currentStage? null: 
                        isDone ? IjudiColors.color6 : IjudiColors.color6,
            width: cardWidth,
            child: Container(
                height: 120,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    cardWidth<= 220 ? Container() : 
                     Lottie.asset(LOTTIE_BY_STAGE[viewModel.stage],
                        animate: viewModel.timerStarted,
                        fit: BoxFit.fill, width: 90),
                    Container(
                      width: cardWidth * 0.4,
                      child: Text(
                        text,
                        style: IjudiStyles.CARD_SHOP_DISCR,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    isDone? Image.asset("assets/images/done.png", width: 50,):
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${viewModel.countDownMinutes}:${viewModel.countDownSeconds}",
                          style: IjudiStyles.COUNT_DOWN,
                        ),
                        Text(
                          "minutes",
                          style: IjudiStyles.COUNT_DOWN_LABEL,
                        )
                      ],
                    )
                  ],
                )))
      ],
    );
  }
}
