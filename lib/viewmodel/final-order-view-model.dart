import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FinalOrderViewModel extends BaseViewModel {
  
  final Order order;

  Shop shop;
  ApiService apiService;

  FinalOrderViewModel({@required this.order, 
    @required this.apiService});

  @override
  void initialize() {
    shop = apiService.findShopById("s");
  }
  
  void moveNextStage() {
    order.moveNextStage();
    notifyChanged();
  }

  int get stage => order.stage;

  

}
