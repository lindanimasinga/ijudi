
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: false)
class Order {

  String id;
  Shipping shippingData = Shipping();
  PaymentType paymentType;
  Basket basket = Basket();
  String customerId;
  String shopId;
  @JsonKey(fromJson: dateFromJson)
  DateTime date;
  int stage = 0;

  UserProfile _customer;
  Shop _shop;

  String description;

  Order();
  
  double get totalAmount => basket.getBasketTotalAmount() + shippingData.fee;

  @JsonKey(ignore: true)
  Shop get shop => _shop;

  @JsonKey(ignore: true)
  set shop(Shop shop) {
    _shop = shop;
    shopId = _shop.id;
  }

  @JsonKey(ignore: true)
  UserProfile get customer => _customer;
  
  @JsonKey(ignore: true)
  set customer(UserProfile customer) {
    _customer = customer;
    customerId = _customer.id;
  }

  void moveNextStage() {
    if(stage < 3 )
      stage  = stage + 1; 
  }
  
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this); 

  static DateTime dateFromJson(String date) {
    return DateTime.parse(date).toLocal();
  }
  
}

enum ShippingType {
  COLLECTION,
  DELIVERY
}

enum PaymentType {
  UKHESHE
}

@JsonSerializable(includeIfNull: false)
class Shipping {

  String fromAddress;
  String toAddress;
  String additionalInstructions;
  ShippingType type;
  double fee;
  UserProfile messenger;

  Shipping();

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingToJson(this); 
}