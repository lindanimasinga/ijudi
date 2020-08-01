import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ijudi/components/ijudi-card.dart';
import 'package:ijudi/components/mv-stateful-widget.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/util/theme-utils.dart';
import 'package:ijudi/viewmodel/order-progress-view-model.dart';
import 'package:lottie/lottie.dart';

class OrderProgressStageComponent
    extends MvStatefulWidget<OrderProgressViewModel> {

  OrderProgressStageComponent(
      {@required OrderProgressViewModel viewModel}) : super(viewModel);

  @override
  Widget build(BuildContext context) {

    int xValue = viewModel.onlineDeliveryStages[viewModel.stage] - viewModel.onlineDeliveryStages[viewModel.currentStage];      
    double cardWidth = (-(44/3) * pow(xValue, 2)) + 352.0;
    cardWidth = cardWidth < 180 ? 180 : cardWidth;
    double elevation = ((-0.5 * pow(xValue, 2)) + 5.0).abs();
        
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(bottom: 8, left: 16),
          child: Text(viewModel.label, style: IjudiStyles.HEADER_TEXT),
        ),
        IJudiCard(
            elevation: elevation,
            color: viewModel.stage == viewModel.currentStage? null: 
                        viewModel.isCompleted ? IjudiColors.color6 : IjudiColors.color6,
            width: cardWidth,
            child: Container(
                height: 120,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    cardWidth <= 220 ? Container() : 
                     Lottie.asset(viewModel.LOTTIE_BY_STAGE[viewModel.stage],
                        animate: viewModel.isCurrentStage,
                        fit: BoxFit.fill, width: 90),
                    Container(
                      width: cardWidth * (viewModel.isCurrentStage || viewModel.isCompleted ? 0.4 : 0.5),
                      child: Text(
                        viewModel.messageMap[viewModel.stage],
                        style: IjudiStyles.CARD_SHOP_DISCR,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    viewModel.isCompleted ? Image.asset("assets/images/done.png", width: 50,):Container()
                  ],
                )))
      ],
    );
  }
}
