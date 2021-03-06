import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ijudi/api/api-error-response.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/device.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/storage-manager.dart';

class ApiService {

  String apiUrl;
  static const TIMEOUT_SEC = 20;
  final StorageManager storageManager;

  ApiService({this.storageManager, this.apiUrl});

  get currentUserPhone => storageManager.mobileNumber;

  get currentUserId => storageManager.getIjudiUserId();
  
  Future<List<Shop>> findAllShopByLocation(double latitude, double longitude, double rage, int size) async {
    logger.log("fetching all shops in range $rage");
    var event = await http.get('$apiUrl/store?latitude=$latitude&longitude=$longitude&range=$rage&size=$size&storeType=FOOD')
        .timeout(Duration(seconds: TIMEOUT_SEC));

    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

    Future<List<Shop>> findFeaturedShopByLocation(double latitude, double longitude, double rage, int size) async {
      logger.log("fetching fetured shops in range $rage");
      var event = await http.get('$apiUrl/store?featured=true&latitude=$latitude&longitude=$longitude&range=$rage&size=$size&storeType=FOOD')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Stock>> findAllStockByShopId(String id) async {

    logger.log("fetching stock shops");
      var event = await http.get('$apiUrl/store/$id/stock')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Stock.fromJson(f)).toList();
  }

  Future<Shop> findShopById(String id) async {
    logger.log("fetching fetured shops");
    var event = await http.get('$apiUrl/store/$id')
          .timeout(Duration(seconds: TIMEOUT_SEC));
          
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
  
    return Shop.fromJson(json.decode(event.body));
  }

  Future<UserProfile> findUserByPhone(String phone) async {

    logger.log("finding user by phone $phone");
    var event = await http.get('$apiUrl/user/$phone')
            .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) {
      logger.log(event.statusCode.toString());
      logger.log(event.body);
      throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    }       
    
    return UserProfile.fromJson(json.decode(event.body));
  }

  Future<UserProfile> findUserById(String id) async {

    logger.log("finding user by id $id");
    var event = await http.get('$apiUrl/user/$id')
            .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) {
      logger.log(event.statusCode.toString());
      logger.log(event.body);
      throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    }       
    
    return UserProfile.fromJson(json.decode(event.body));
  }

  Future<List<UserProfile>> findNearbyMessangers(double latitude, double longitude, double range) async {
    var event = await http
        .get('$apiUrl/user?latitude=$latitude&longitude=$longitude&range=$range&role=${describeEnum(ProfileRoles.MESSENGER)}')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    Iterable list = json.decode(event.body);
    return list.map((f) => UserProfile.fromJson(f)).toList();
  }

  Future registerUser(UserProfile user) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(user);
    logger.log(request);
    var event = await http
        .post('$apiUrl/user', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    user = UserProfile.fromJson(json.decode(event.body));
    storageManager.saveIjudiUserId(user.id);
    return event;
  }

  Future<List<Advert>> findAllAdsByLocation(double latitude, double longitude, double rage, int size) async {
      
      logger.log("fetching fetured Ads");
      var event = await http.get('$apiUrl/promotion')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Advert.fromJson(f)).toList();
  }

  Future<String> updateShop(Shop shop) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(shop);
    logger.log(request);
    var event = await http
        .patch('$apiUrl/store/${shop.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return event.body;
  }

  Future<String> addStockItem(String id, Stock stock) async {
    
    logger.log("adding stock..");
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(stock);
    print(request);
    var event = await http.patch('$apiUrl/store/$id/stock', headers: headers, body: request, )
        .timeout(Duration(seconds: TIMEOUT_SEC));

    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     

    return event.body;
  }

  Future<Order> startOrder(Order order) async {

    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(order);
    print(request);
    var event = await http
        .post('$apiUrl/order', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future<Order> completeOrderPayment(Order order) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(order);
    print(request);
    logger.log("Try 1");
    await Future.delayed(Duration(seconds: 3));
    var event = await http
        .patch('$apiUrl/order/${order.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);

    await Future.delayed(Duration(seconds: 3));

    if(event.statusCode != 200){
       logger.log("Try 2");
       event = await http
        .patch('$apiUrl/order/${order.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
      logger.log(event.body);
    }

    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future<List<Order>> findOrdersByPhoneNumber(String phone) async {
    logger.log("fetching all orders for customer phone number $phone");
    var event = await http.get('$apiUrl/order?phone=$phone')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<List<Shop>> findShopByOwnerId(String ownerId) async {
        logger.log("fetching owner shops");
    var event = await http.get('$apiUrl/store?ownerId=$ownerId')
          .timeout(Duration(seconds: TIMEOUT_SEC));
          
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Order>> findOrdersByShopId(String id) async {
    logger.log("fetching all orders for shope with id $id");
    var event = await http.get('$apiUrl/order?storeId=$id')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<Order> progressOrderNextStage(String id) async {
    var event = await http.get('$apiUrl/order/$id/nextstage')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future registerDevice(Device device) async {
        Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(device);
    logger.log(request);
    var event = await http
        .post('$apiUrl/device', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    device = Device.fromJson(json.decode(event.body));
    storageManager.deviceId = device.id;
    return event;
  }

  Future updateDevice(Device device) async {
        Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(device);
    logger.log(request);
    var event = await http
        .patch('$apiUrl/device/${device.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return event;
  }

  Future<List<Order>> findOrdersByMessengerId(String messengerId) async {
    logger.log("fetching all orders for messenger with id $messengerId");
    var event = await http.get('$apiUrl/order?messengerId=$messengerId')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<Order> findOrderById(String id) async {
    var event = await http.get('$apiUrl/order/$id')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
    return Order.fromJson(json.decode(event.body));
  }
}
