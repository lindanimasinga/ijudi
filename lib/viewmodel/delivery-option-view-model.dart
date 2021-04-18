import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/business-hours.dart';
import 'package:ijudi/model/day.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';
import 'package:intl/intl.dart';

class DeliveryOptionsViewModel extends BaseViewModel {
  Order order;
  final UkhesheService ukhesheService;
  final ApiService apiService;
  bool fetchingMessangers = false;

  BuildingType _buildingType = BuildingType.HOUSE;
  String _buildingName = "";
  String _unitNumner = "";
  List<UserProfile> _messangers = [];

  DeliveryOptionsViewModel(
      {@required this.ukhesheService,
      @required this.order,
      @required this.apiService});

  List<UserProfile> get messangers => _messangers;

  String get buildingName => _buildingName;
  set buildingName(String buildingName) {
    _buildingName = buildingName;
    order.shippingData.buildingName = buildingName;
  }

  String get unitNumner => _unitNumner;
  set unitNumner(String unitNumner) {
    _unitNumner = unitNumner;
    order.shippingData.unitNumber = unitNumner;
  }

  BuildingType get buildingType => _buildingType;
  set buildingType(BuildingType buildingType) {
    _buildingType = buildingType;
    order.shippingData.buildingType = _buildingType;
    notifyChanged();
  }

  get isBuildingInfoRequired =>
      order.shippingData.buildingType == BuildingType.APARTMENT ||
      order.shippingData.buildingType == BuildingType.OFFICE;

  get allowedOrder =>
      fetchingMessangers ||
      messangers.length > 0 ||
      order.shippingData.type == ShippingType.COLLECTION;

  set messangers(List<UserProfile> messangers) {
    _messangers = messangers;
    notifyChanged();
  }

  ShippingType get shippingType => order.shippingData.type;
  set shippingType(ShippingType delivery) {
    order.shippingData.type = delivery;
    if (!allowedOrder) {
      showError(
          error:
              "No drivers available on your area. Only collections are allowed");
    }
    if (order.shippingData.type == ShippingType.DELIVERY &&
        order.shippingData.buildingType == null) {
      order.shippingData.buildingType = BuildingType.HOUSE;
    }
    notifyChanged();
  }

  get deliveryAddress => order.shippingData.toAddress;
  set deliveryAddress(deliveryAddress) {
    order.shippingData.toAddress = deliveryAddress;
    notifyChanged();
    findMessengers();
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

  DateTime get arrivalTime => order.shippingData.pickUpTime;

  bool get isValidCollectionTime {
    var pickUpDateTime = order.shippingData.pickUpTime;
    int openTime = int.parse(
        "${DateFormat('HHmm').format(Utils.timeOfDayAsDateTime(businessHours[0].open))}");
    int pickUpTime = int.parse("${DateFormat('HHmm').format(pickUpDateTime)}");
    int closeTime = int.parse(
        "${DateFormat('HHmm').format(Utils.timeOfDayAsDateTime(businessHours[0].close))}");
    return openTime <= pickUpTime && closeTime >= pickUpTime;
  }

  set arrivalTime(DateTime arrivalTime) {
    order.shippingData.pickUpTime = arrivalTime;
    if (!isValidCollectionTime) {
      showError(
          error:
              "Your pick up time should be within the collection times indicated.");
    }
    notifyChanged();
  }

  @override
  void initialize() {
    //
    order.shippingData = Shipping();
    order.shippingData.toAddress = order.customer.address;
    order.shippingData.type = ShippingType.COLLECTION;
    order.shippingData.fromAddress = order.shop.name;
    order.shippingData.fee = 0;
    findMessengers();
  }

  startOrder() {
    if (!allowedOrder) {
      showError(
          error:
              "No drivers available on your area. Only collections are allowed");
      return;
    }

    if (order.shippingData.type == ShippingType.COLLECTION &&
        !isValidCollectionTime) {
      showError(
          error:
              "Your pick up time should be within the collection times indicated.");
      return;
    }

    progressMv.isBusy = true;
    if (order.shippingData.type == ShippingType.DELIVERY) {
      var storeMessengeId = order.shop.storeMessenger?.id;
      var messenger = messangers?.firstWhere(
          (item) => item.id == storeMessengeId,
          orElse: () => messangers[0]);
      order.shippingData.messenger = messenger;
      order.shippingData.messengerId = messenger.id;
    }

    order.description = "order from ${order.shop.name}";
    apiService.startOrder(order).asStream().map((resp) {
      var oldOrder = order;
      order = resp;
      order.customer = oldOrder.customer;
      order.shop = oldOrder.shop;
      order.shippingData.messenger = oldOrder.shippingData.messenger;
      order.description =
          "Payment from ${order.customer.mobileNumber}: order ${resp.id}";
    }).listen((customerResponse) {
      BaseViewModel.analytics.logEvent(name: "order.start", parameters: {
        "shop": order.shop.name,
        "Order Id": order.id,
        "Delivery": order.shippingData.type.toString(),
        "Total Amount": order.totalAmount
      }).then((value) => {});

      Navigator.popAndPushNamed(context, PaymentView.ROUTE_NAME,
          arguments: order);
    }, onError: (handleError) {
      showError(error: handleError);
      log("handleError", error: handleError);
    }, onDone: () {
      progressMv.isBusy = false;
    });
  }

  findMessengers() {
    log("searching for messengers");
    fetchingMessangers = true;
    locationFromAddress(order.shippingData.toAddress)
        .asStream()
        .map((data) => data[0])
        .asyncExpand((position) => apiService
            .findNearbyMessangers(position.latitude, position.longitude,
                Config.currentConfig.rangeMap["10km"])
            .asStream())
        .listen((messa) {
      messangers = messa;
    }, onDone: () {
      fetchingMessangers = false;
    });
  }
}
