import 'dart:math';

import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/userProfile.dart';

class Order {

  Shipping shippingData;
  Busket busket;
  String id = Random().nextInt(1000000).toString();
  DateTime date = DateTime.now();
  int _stage = 0;

  int get stage => _stage;
  
  double get totalAmount => busket.getBusketTotalAmount() + shippingData.fee;
  UserProfile get customer => busket.customer;

  void moveNextStage() {
    if(_stage < 3 )
      _stage  = _stage + 1; 
  }
  
}

enum ShippingType {
  COLLECTION,
  DELIVERY
}

class Shipping {

  String fromAddress;
  String toAddress;
  String additionalInstructions;
  ShippingType type;
  double fee;
  UserProfile messanger;
}