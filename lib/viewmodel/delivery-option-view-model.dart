import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class DeliveryOptionsViewModel extends BaseViewModel {

  final Busket busket;
  
  DeliveryOptionsViewModel(this.busket);

  List<UserProfile> _messangers;

  List<UserProfile> get messangers => _messangers;

  set messangers(List<UserProfile> messangers) {
    _messangers = messangers;
  }

  ShippingType _delivery = ShippingType.DELIVERY;

  ShippingType get delivery => _delivery;
  set delivery(ShippingType delivery) {
    newOrder.shippingData.type = delivery;
    notifyChanged();
  }

  Order _newOrder;

  Order get newOrder => _newOrder;
  set newOrder(Order newOrder) {
    _newOrder = newOrder;
  }

  get deliveryAddress => newOrder.shippingData.toAddress;
  set deliveryAddress(deliveryAddress) {
    newOrder.shippingData.toAddress = deliveryAddress;
    notifyChanged();
  }

  @override
  void initialize() {
    messangers = ApiService.findNearbyMessangers("");
    newOrder = Order();
    newOrder.busket = busket;
    newOrder.shippingData = Shipping();
    newOrder.shippingData.type = ShippingType.COLLECTION;
    newOrder.shippingData.messanger = messangers[0];
    newOrder.shippingData.fromAddress = busket.shop.name;
    newOrder.shippingData.toAddress= busket.customer.address;
    newOrder.shippingData.fee = 10;
  }

  proceed() {
    Navigator.pushNamed(context, PaymentView.ROUTE_NAME, arguments: newOrder);
  }
  
}