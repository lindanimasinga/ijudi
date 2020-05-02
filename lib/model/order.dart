import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/userProfile.dart';

class Order {

  Shipping shippingData;
  Busket busket;
  
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