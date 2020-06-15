
import 'package:flutter/material.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: false)
class Order {
  String id;
  Shipping shippingData = Shipping();
  PaymentType paymentType = PaymentType.UKHESHE;
  OrderType orderType = OrderType.ONLINE;
  bool hasVat;
  Basket basket = Basket();
  String customerId;
  String shopId;
  @JsonKey(fromJson: dateFromJson)
  DateTime date;
  OrderStage stage = OrderStage.STAGE_0_CUSTOMER_NOT_PAID;

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

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  static DateTime dateFromJson(String date) {
    return DateTime.parse(date).toLocal();
  }
}

enum ShippingType { COLLECTION, DELIVERY }

enum PaymentType { UKHESHE, CASH }

enum OrderType { ONLINE, INSTORE}

@JsonSerializable(includeIfNull: false)
class Shipping {
  String fromAddress;
  String toAddress;
  String additionalInstructions;
  ShippingType type;
  double fee = 0;
  UserProfile messenger;
  @JsonKey(fromJson: dateFromJson, toJson: dateToJson)
  TimeOfDay pickUpTime = TimeOfDay(hour: 0, minute: 0);

  Shipping();

  factory Shipping.fromJson(Map<String, dynamic> json) =>
      _$ShippingFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingToJson(this);

  static TimeOfDay dateFromJson(String dateString) {
    if(dateString == null) return null;
    var date = DateTime.parse(dateString);
    return TimeOfDay.fromDateTime(date);
  }

  static String dateToJson(TimeOfDay time) {
    var date =DateTime.now();
    var pickupDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return pickupDate.toIso8601String();
  }
}


enum OrderStage {

    STAGE_0_CUSTOMER_NOT_PAID,
    STAGE_1_WAITING_STORE_CONFIRM,
    STAGE_2_STORE_PROCESSING,
    STAGE_3_READY_FOR_COLLECTION,
    STAGE_4_ON_THE_ROAD,
    STAGE_5_ARRIVED,
    STAGE_6_WITH_CUSTOMER,
    STAGE_7_PAID_SHOP
}
