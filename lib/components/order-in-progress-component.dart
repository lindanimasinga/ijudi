import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/components/shop-component.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/order-progress-view-model.dart';
import 'package:lottie/lottie.dart';

class OrderProgressStageComponent
    extends MvStatefulWidget<OrderProgressViewModel> {
  
  static const LOTTIE_BY_STAGE = {
    0 : "assets/lottie/loading.json",
    1 : "assets/lottie/packing.json",
    2 : "assets/lottie/delivery.json",
    3 : "assets/lottie/food.json",
    4 : "assets/lottie/done.json"
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

    int xValue = viewModel.stage - viewModel.currentStage;      
    double cardWidth = (-(44/3) * pow(xValue, 2)) + 352.0;
    double elevation = ((-0.5 * pow(xValue, 2)) + 5.0).abs();
    bool isDone =  viewModel.stage < viewModel.currentStage;    
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
