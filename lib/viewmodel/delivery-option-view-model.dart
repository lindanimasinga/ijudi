import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/business-hours.dart';
import 'package:ijudi/model/day.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';

class DeliveryOptionsViewModel extends BaseViewModel {
  Order order;
  final UkhesheService ukhesheService;
  final ApiService apiService;
  bool fetchingMessangers = false;

  DeliveryOptionsViewModel(
      {@required this.ukhesheService,
      @required this.order,
      @required this.apiService});

  List<UserProfile> _messangers = [];

  List<UserProfile> get messangers => _messangers;

  get allowedOrder => fetchingMessangers || messangers.length > 0 || order.shippingData.type == ShippingType.COLLECTION;

  set messangers(List<UserProfile> messangers) {
    _messangers = messangers;
    notifyChanged();
  }

  ShippingType get shippingType => order.shippingData.type;
  set shippingType(ShippingType delivery) {
    order.shippingData.type = delivery;
    if(!allowedOrder) {
      showError(error: "No drivers available on your area. Only collections are allowed");
    }
    notifyChanged();
  }

  get deliveryAddress => order.shippingData.toAddress;
  set deliveryAddress(deliveryAddress) {
    order.shippingData.toAddress = deliveryAddress;
    findMessengers();
    notifyChanged();
  }

  get isDelivery => shippingType == ShippingType.DELIVERY;

  List<BusinessHours> get businessHours {
    var hours = order.shop.businessHours;
    if (hours != null) return hours;

    hours = [
      BusinessHours(Day.MONDAY, TimeOfDay(hour: 8, minute: 0),
          TimeOfDay(hour: 17, minute: 0)),
      BusinessHours(Day.TUESDAY, TimeOfDay(hour: 8, minute: 0),
          TimeOfDay(hour: 17, minute: 0)),
      BusinessHours(Day.WEDNESDAY, TimeOfDay(hour: 8, minute: 0),
          TimeOfDay(hour: 17, minute: 0)),
      BusinessHours(Day.THURSDAY, TimeOfDay(hour: 8, minute: 0),
          TimeOfDay(hour: 17, minute: 0)),
      BusinessHours(Day.FRIDAY, TimeOfDay(hour: 8, minute: 0),
          TimeOfDay(hour: 17, minute: 0)),
    ];
    return hours;
  }

  TimeOfDay get arrivalTime => order.shippingData.pickUpTime;

  bool get isValidCollectionTime {
    var pickUpDateTime = Utils.timeOfDayAsDateTime(order.shippingData.pickUpTime);
    var closingTime = Utils.timeOfDayAsDateTime(businessHours[0].close);
    var openTime = Utils.timeOfDayAsDateTime(businessHours[0].open);

    return openTime.isBefore(pickUpDateTime) && closingTime.isAfter(pickUpDateTime);
  }

  set arrivalTime(TimeOfDay arrivalTime) {
    order.shippingData.pickUpTime = arrivalTime;
    if(!isValidCollectionTime) {
      showError(error: "Your pick up time should be within the collection times indicated.");
    }
    notifyChanged();
  }

  @override
  void initialize() {
    //shipping
    order.shippingData.toAddress = order.customer.address;
    order.shippingData.type = ShippingType.COLLECTION;
    order.shippingData.fromAddress = order.shop.name;
    order.shippingData.fee = 0;
    findMessengers();
  }

  startOrder() {
    if(!allowedOrder) {
      showError(error : "No drivers available on your area. Only collections are allowed");
      return;
    }

    if(order.shippingData.type == ShippingType.COLLECTION && !isValidCollectionTime) {
      showError(error: "Your pick up time should be within the collection times indicated.");
      return;
    }
    
    progressMv.isBusy = true;
    if(order.shippingData.type == ShippingType.DELIVERY) {
      order.shippingData.messenger = messangers[0];
    }
    apiService
        .startOrder(order)
        .asStream()
        .map((resp) {
          order.id = resp.id;
          order.date = resp.date;
          order.hasVat = resp.hasVat;
          order.serviceFee = resp.serviceFee;
          order.shippingData.fee = resp.shippingData.fee;
          order.description =
              "Payment from ${order.customer.mobileNumber}: order ${order.id}";
        })
        .asyncExpand(
            (element) => ukhesheService.getAccountInformation().asStream())
        .listen((customerResponse) {
          availableBalance = customerResponse;

          BaseViewModel.analytics.logEvent(name: "order-init", parameters: {
            "shop": order.shop.name,
            "Delivery": order.shippingData.type
          }).then((value) => {});

          Navigator.pushNamed(context, PaymentView.ROUTE_NAME,
              arguments: order);
        }, onError: (handleError) {
          showError(error : handleError);
          log("handleError", error: handleError);
        }, onDone: () {
          progressMv.isBusy = false;
        });
  }

  set availableBalance(CustomerInfoResponse value) {
    order.customer.bank = value;
    print(order.customer.bank);
    print(order.customer.bank.currentBalance);
    order.customer.bank.currentBalance =
        order.customer.bank.currentBalance == null
            ? 0
            : order.customer.bank.currentBalance;
    order.customer.bank.availableBalance =
        order.customer.bank.availableBalance == null
            ? 0
            : order.customer.bank.availableBalance;
    notifyChanged();
  }

  findMessengers() {
        log("searching for messegers");
        fetchingMessangers = true;
        Geolocator()
        .placemarkFromAddress(order.shippingData.toAddress)
        .asStream()
        .map((data) => data[0].position)
        .asyncExpand((position) => apiService
            .findNearbyMessangers(
                position.latitude, position.longitude, Utils.rangeMap["15km"])
            .asStream())
        .listen((messa) {
          messangers = messa;
        }, onDone: () {
          fetchingMessangers = false;
        });
  }
}
