import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/business-hours.dart';
import 'package:ijudi/model/day.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/util/message-dialogs.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:intl/intl.dart';

class DeliveryOptionsViewModel extends BaseViewModel with MessageDialogs {
  Order order;
  final UkhesheService ukhesheService;
  final ApiService apiService;
  final StorageManager storageManager;
  bool fetchingMessangers = false;

  BuildingType _buildingType = BuildingType.HOUSE;
  String _buildingName = "";
  String _unitNumner = "";
  List<UserProfile> _messangers = [];

  DeliveryOptionsViewModel(
      {@required this.ukhesheService,
      @required this.order,
      @required this.apiService,
      @required this.storageManager});

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
      order.shippingData.type == ShippingType.SCHEDULED_DELIVERY;

  set messangers(List<UserProfile> messangers) {
    _messangers = messangers;
    notifyChanged();
  }

  ShippingType get shippingType => order.shippingData.type;
  set shippingType(ShippingType delivery) {
    order.shippingData.type = delivery;
    if (!allowedOrder) {
      showError(error: "No drivers available on your area at the moment.");
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

  get isDeliveryNow {
    return shippingType == ShippingType.DELIVERY;
  }

  bool get isLoggedIn => storageManager.isLoggedIn;

  List<BusinessHours> get businessHours {
    var hours = order.shop.businessHours;
    if (hours != null) return hours;

    hours = [
      BusinessHours(
          Day.MONDAY, DateTime(2021, 1, 1, 8, 0), DateTime(2021, 1, 1, 17, 0)),
      BusinessHours(
          Day.TUESDAY, DateTime(2021, 1, 1, 8, 0), DateTime(2021, 1, 1, 17, 0)),
      BusinessHours(Day.WEDNESDAY, DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 17, 0)),
      BusinessHours(Day.THURSDAY, DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 17, 0)),
      BusinessHours(
          Day.FRIDAY, DateTime(2021, 1, 1, 8, 0), DateTime(2021, 1, 1, 17, 0)),
    ];
    return hours;
  }

  DateTime get arrivalTime => order.shippingData.pickUpTime;

  bool get isValidDeliveryTime {
    var pickUpDateTime = order.shippingData.pickUpTime;
    var businessDay = businessHours.firstWhere((day) =>
        DateFormat('EEEE').format(pickUpDateTime).toUpperCase() ==
        describeEnum(day.day), orElse: () => null,);

    if(businessDay == null) {
      return false;
    }    

    int openTime = int.parse("${DateFormat('HHmm').format(businessDay.open)}");
    int pickUpTime = int.parse("${DateFormat('HHmm').format(pickUpDateTime)}");
    int closeTime =
        int.parse("${DateFormat('HHmm').format(businessDay.close)}");
    log("open $openTime, delivery $pickUpTime, close $closeTime");
    return openTime <= pickUpTime && closeTime >= pickUpTime;
  }

  set arrivalTime(DateTime arrivalTime) {
    order.shippingData.pickUpTime = arrivalTime;
    if (!isValidDeliveryTime) {
      showError(
          error:
              "Your delivery should be within the delivery times indicated.");
    }
    notifyChanged();
  }

  @override
  void initialize() {
    //
    order.shippingData = Shipping();
    order.shippingData.toAddress =
        order.customer != null ? order.customer.address : "";
    order.shippingData.buildingType = BuildingType.HOUSE;
    order.shippingData.fromAddress = order.shop.name;
    order.shippingData.fee = 0;
    order.shippingData.type = order.shop.scheduledDeliveryAllowed
        ? ShippingType.SCHEDULED_DELIVERY
        : ShippingType.DELIVERY;
    findMessengers();
  }

  startOrder() {
    if (!allowedOrder) {
      showError(error: "No drivers available on your area at the moment.");
      return;
    }

    if (order.shippingData.type == ShippingType.SCHEDULED_DELIVERY &&
        !isValidDeliveryTime) {
      showError(
          error:
              "Your delivery should be within the delivery times indicated.");
      return;
    }

    if (!isLoggedIn) {
      showLoginMessage(context, params: order.shippingData.toAddress);
      return;
    }

    if (order.shippingData.type == ShippingType.DELIVERY) {
      var storeMessengeId = order.shop.storeMessenger?.id;
      var messenger = messangers?.firstWhere(
          (item) => item.id == storeMessengeId,
          orElse: () => messangers[0]);
      order.shippingData.messenger = messenger;
      order.shippingData.messengerId = messenger.id;
    }

    var userId = apiService.currentUserPhone;
    progressMv.isBusy = true;
    var streamCall = order.customer == null
        ? apiService
            .findUserByPhone(userId)
            .asStream()
            .map((user) => order.customer = user)
        : Stream.value("");

    order.description = "order from ${order.shop.name}";
    streamCall
        .asyncExpand((event) => apiService.startOrder(order).asStream())
        .map((resp) {
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
