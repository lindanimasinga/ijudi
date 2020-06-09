import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class FinalOrderViewModel extends BaseViewModel {
  
  final Order order;

  Shop shop = Utils.createPlaceHolder();
  ApiService apiService;

  FinalOrderViewModel({@required this.order, 
    @required this.apiService});

  @override
  void initialize() {
    apiService.findShopById("42b2e967-d653-4085-a7b7-ef20301acec8")
      .asStream()
      .listen((shp) => shop = shp
      ,onError: (e) {
        hasError = true;
        errorMessage = e.toString();
      });
  }
  
  void moveNextStage() {
    order.moveNextStage();
    notifyChanged();
  }

  int get stage => order.stage;

  

}
