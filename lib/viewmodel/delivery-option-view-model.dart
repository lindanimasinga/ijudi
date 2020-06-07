
import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/business-hours.dart';
import 'package:ijudi/model/day.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/view/payment-view.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';

class DeliveryOptionsViewModel extends BaseViewModel {

  Order order;
  final UkhesheService ukhesheService;
  final ApiService apiService;
  
  DeliveryOptionsViewModel({@required this.ukhesheService, 
    @required this.order,
    @required this.apiService});

  List<UserProfile> _messangers = [];

  List<UserProfile> get messangers => _messangers;

  set messangers(List<UserProfile> messangers) {
    _messangers = messangers;
    notifyChanged();
  }

  ShippingType get shippingType => order.shippingData.type;
  set shippingType(ShippingType delivery) {
    order.shippingData.type = delivery;
    notifyChanged();
  }

  get deliveryAddress => order.shippingData.toAddress;
  set deliveryAddress(deliveryAddress) {
    order.shippingData.toAddress = deliveryAddress;
    notifyChanged();
  }

  get isDelivery => shippingType == ShippingType.DELIVERY;

  get businessHours {
      var hours = order.shop.businessHours;
      if(hours != null) return hours;

      hours = [
        BusinessHours(Day.MONDAY, TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        BusinessHours(Day.TUESDAY, TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        BusinessHours(Day.WEDNESDAY, TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        BusinessHours(Day.THURSDAY, TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
        BusinessHours(Day.FRIDAY, TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 17, minute: 0)),
      ];
      return hours;
    }

  TimeOfDay get arrivalTime => order.shippingData.pickUpTime;

  set arrivalTime(TimeOfDay arrivalTime) {
    order.shippingData.pickUpTime = arrivalTime;
    notifyChanged();
  }

  @override
  void initialize() {
    //shipping
    apiService.findNearbyMessangers("")
      .asStream()
      .listen((messa) { 
        messangers = messa;
        order.shippingData.messenger = messangers[0];
      });
    order.shippingData.toAddress= order.customer.address;
    order.shippingData.type = ShippingType.COLLECTION;
    order.shippingData.fromAddress = order.shop.name;
    order.shippingData.fee = 0;
  }

  startOrder() {
    progressMv.isBusy = true;
    apiService.startOrder(order)
      .asStream()
      .map((resp) {
        order.id = resp.id;
        order.date = resp.date;
        order.hasVat = resp.hasVat;
        order.description = "Payment from ${order.customer.mobileNumber}: order ${order.id}";
      })
      .asyncExpand((element) => ukhesheService.getAccountInformation().asStream())
      .listen((customerResponse) {
        availableBalance = customerResponse;
        Navigator.pushNamed(context, PaymentView.ROUTE_NAME, arguments: order);
      }, 
      onError: (handleError) {
        hasError = true;
        errorMessage = handleError.toString();
      //log(handleError);
      },
      onDone: () {
        progressMv.isBusy = false;
    });
  }

  set availableBalance(CustomerInfoResponse value) {
    order.customer.bank = value;
    print(order.customer.bank);
    print(order.customer.bank.currentBalance);
    order.customer.bank.currentBalance =
      order.customer.bank.currentBalance == null? 0 : order.customer.bank.currentBalance;
    order.customer.bank.availableBalance =
      order.customer.bank.availableBalance == null? 0 : order.customer.bank.availableBalance;
    notifyChanged();
  }
  
}