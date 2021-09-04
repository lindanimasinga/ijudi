import 'dart:convert';
import 'dart:developer' as logger;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ijudi/api/api-error-response.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/device.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/storage-manager.dart';

class ApiService {
  static const TIMEOUT_SEC = 20;
  final StorageManager? storageManager;

  ApiService({this.storageManager});

  get currentUserPhone => storageManager!.mobileNumber;

  get currentUserId => storageManager!.getIjudiUserId();

  String get apiUrl => Config.currentConfig!.iZingaApiUrl;

  Future<List<Shop>> findAllShopByLocation(
      double latitude, double longitude, double? rage, int size) async {
    logger.log("fetching all shops in range $rage");
    var url = Uri.parse(
        '$apiUrl/store?latitude=$latitude&longitude=$longitude&range=$rage&size=$size&storeType=FOOD');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Shop>> findFeaturedShopByLocation(
      double latitude, double longitude, double? rage, int size) async {
    logger.log("fetching fetured shops in range $rage");
    var url = Uri.parse(
        '$apiUrl/store?featured=true&latitude=$latitude&longitude=$longitude&range=$rage&size=$size&storeType=FOOD');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Stock>> findAllStockByShopId(String? id) async {
    logger.log("fetching stock shops");
    var url = Uri.parse('$apiUrl/store/$id/stock');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Stock.fromJson(f)).toList();
  }

  Future<Shop> findShopById(String? id) async {
    logger.log("fetching fetured shops");
    var url = Uri.parse('$apiUrl/store/$id');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    return Shop.fromJson(json.decode(event.body));
  }

  Future<UserProfile> findUserByPhone(String? phone) async {
    logger.log("finding user by phone $phone");
    var url = Uri.parse('$apiUrl/user/$phone');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200) {
      logger.log(event.statusCode.toString());
      logger.log(event.body);
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    }

    return UserProfile.fromJson(json.decode(event.body));
  }

  Future<UserProfile> findUserById(String? id) async {
    logger.log("finding user by id $id");
    var url = Uri.parse('$apiUrl/user/$id');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200) {
      logger.log(event.statusCode.toString());
      logger.log(event.body);
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    }

    return UserProfile.fromJson(json.decode(event.body));
  }

  Future<List<UserProfile>> findNearbyMessangers(
      double latitude, double longitude, double? range) async {
    var url = Uri.parse(
        '$apiUrl/user?latitude=$latitude&longitude=$longitude&range=$range&role=${describeEnum(ProfileRoles.MESSENGER)}');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    Iterable list = json.decode(event.body);
    return list.map((f) => UserProfile.fromJson(f)).toList();
  }

  Future<UserProfile> registerUser(UserProfile user) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    logger.log("registering user ${user.mobileNumber}");
    var request = json.encode(user);
    logger.log(request);
    var url = Uri.parse('$apiUrl/user');
    var event = await http
        .post(url, headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    user = UserProfile.fromJson(json.decode(event.body));
    storageManager!.saveIjudiUserId(user.id);
    return user;
  }

  Future<List<Advert>> findAllAdsByLocation(
      double latitude, double longitude, double? rage, int size) async {
    logger.log("fetching fetured Ads");
    var url = Uri.parse('$apiUrl/promotion');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Advert.fromJson(f)).toList();
  }

  Future<String> updateShop(Shop shop) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(shop);
    logger.log(request);
    var url = Uri.parse('$apiUrl/store/${shop.id}');
    var event = await http
        .patch(url, headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return event.body;
  }

  Future<String> addStockItem(String? id, Stock stock) async {
    logger.log("adding stock..");
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(stock);
    print(request);
    var url = Uri.parse('$apiUrl/store/$id/stock');
    var event = await http
        .patch(
          url,
          headers: headers,
          body: request,
        )
        .timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    return event.body;
  }

  Future<Order> startOrder(Order? order) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(order);
    logger.log(request);
    var url = Uri.parse('$apiUrl/order');
    var event = await http
        .post(url, headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future<Order> completeOrderPayment(Order order) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Origin": "app://izinga"
    };

    var request = json.encode(order);
    print(request);
    logger.log("Try 1");
    var url = Uri.parse('$apiUrl/order/${order.id}');
    var event = await http
        .patch(url, headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);

    if (event.statusCode != 200) {
      logger.log("Try 2");
      var url = Uri.parse('$apiUrl/order/${order.id}');
      event = await http
          .patch(url, headers: headers, body: request)
          .timeout(Duration(seconds: TIMEOUT_SEC));
      logger.log(event.body);
    }

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future<List<Order>> findOrdersByPhoneNumber(String? phone) async {
    logger.log("fetching all orders for customer phone number $phone");
    var url = Uri.parse('$apiUrl/order?phone=$phone');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<List<Shop>> findShopByOwnerId(String? ownerId) async {
    logger.log("fetching owner shops");
    var url = Uri.parse('$apiUrl/store?ownerId=$ownerId');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));

    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Order>> findOrdersByShopId(String? id) async {
    logger.log("fetching all orders for shope with id $id");
    var url = Uri.parse('$apiUrl/order?storeId=$id');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<Order> progressOrderNextStage(String? id) async {
    var url = Uri.parse('$apiUrl/order/$id/nextstage');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future registerDevice(Device device) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(device);
    logger.log(request);
    var url = Uri.parse('$apiUrl/device');
    var event = await http
        .post(url, headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    device = Device.fromJson(json.decode(event.body));
    storageManager!.deviceId = device.id;
    return event;
  }

  Future updateDevice(Device device) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(device);
    logger.log(request);
    var url = Uri.parse('$apiUrl/device/${device.id}');
    var event = await http
        .patch(url, headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return event;
  }

  Future<List<Order>> findOrdersByMessengerId(String? messengerId) async {
    logger.log("fetching all orders for messenger with id $messengerId");
    var url = Uri.parse('$apiUrl/order?messengerId=$messengerId');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);

    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<Order> findOrderById(String? id) async {
    var url = Uri.parse('$apiUrl/order/$id');
    var event = await http.get(url).timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if (event.statusCode != 200)
      throw (ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }
}
