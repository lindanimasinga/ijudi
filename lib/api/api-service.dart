import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ijudi/api/api-error-response.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/device.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/storage-manager.dart';

class ApiService {

  static const API_URL = "http://localhost/";
  static const TIMEOUT_SEC = 20;
  final StorageManager storageManager;

  ApiService(this.storageManager);

  get currentUserPhone => storageManager.mobileNumber;

  get currentUserId => storageManager.getIjudiUserId();
  
  Future<List<Shop>> findAllShopByLocation(double latitude, double longitude, double rage, int size) async {
    logger.log("fetching all shops");
    var event = await http.get('$API_URL/store?latitude=$latitude&longitude=$longitude&range=$rage&size=$size')
        .timeout(Duration(seconds: TIMEOUT_SEC));

    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

    Future<List<Shop>> findFeaturedShopByLocation(double latitude, double longitude, double rage, int size) async {
      logger.log("fetching fetured shops");
      var event = await http.get('$API_URL/store?featured=true&latitude=$latitude&longitude=$longitude&range=$rage&size=$size')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Stock>> findAllStockByShopId(String id) async {

    logger.log("fetching stock shops");
      var event = await http.get('$API_URL/store/$id/stock')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Stock.fromJson(f)).toList();
  }

  Future<Shop> findShopById(String id) async {
    logger.log("fetching fetured shops");
    var event = await http.get('$API_URL/store/$id')
          .timeout(Duration(seconds: TIMEOUT_SEC));
          
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
  
    return Shop.fromJson(json.decode(event.body));
  }

  Future<UserProfile> findUserByPhone(String phone) async {

    logger.log("finding user by phone $phone");
    var event = await http.get('$API_URL/user?phone=$phone')
            .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) {
      logger.log(event.statusCode.toString());
      logger.log(event.body);
      throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    }       
    
    return UserProfile.fromJson(json.decode(event.body));
  }

  Future<List<UserProfile>> findNearbyMessangers(String s) async {
    var messagers = <UserProfile>[];

    var messager1 = await findUserByPhone("0812815707");
    messager1.name = "Sandile Ngema";
    messager1.likes = 12;
    messager1.responseTimeMinutes = 2 + Random().nextInt(13);
    messager1.imageUrl =
        "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/man-raising-hand-medium-dark-skin-tone.png";
    messagers.add(messager1);

    var messager2 = await findUserByPhone("0812815707");
    messager2.name = "Xolani Shezi";
    messager2.likes = 12;
    messager2.responseTimeMinutes = 2 + Random().nextInt(13);
    messager2.imageUrl =
        "https://i.pinimg.com/236x/5b/11/99/5b1199b7336b689439563863d8b911e1--black-fathers-father-christmas.jpg";
    messagers.add(messager2);

    return messagers;
  }

  Future registerUser(UserProfile user) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(user);
    logger.log(request);
    var event = await http
        .post('$API_URL/user', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    user = UserProfile.fromJson(json.decode(event.body));
    storageManager.saveIjudiUserId(user.id);
    return event;
  }

  Future<dynamic> verifyCanBuy(Basket basket) async {
    return Future.delayed(Duration(seconds: 2)).asStream();
  }

  Future<List<Advert>> findAllAdsByLocation(double latitude, double longitude, double rage, int size) async {
      
      logger.log("fetching fetured Ads");
      var event = await http.get('$API_URL/promotion')
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
        .patch('$API_URL/store/${shop.id}', headers: headers, body: request)
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
    var event = await http.patch('$API_URL/store/$id/stock', headers: headers, body: request, )
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
        .post('$API_URL/order', headers: headers, body: request)
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
        .patch('$API_URL/order/${order.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);

    await Future.delayed(Duration(seconds: 3));

    if(event.statusCode != 200){
       logger.log("Try 2");
       event = await http
        .patch('$API_URL/order/${order.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
      logger.log(event.body);
    }

    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return Order.fromJson(json.decode(event.body));
  }

  Future<List<Order>> findOrdersByPhoneNumber(String phone) async {
    logger.log("fetching all orders for customer phone number $phone");
    var event = await http.get('$API_URL/order?phone=$phone')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<List<Shop>> findShopByOwnerId(String ownerId) async {
        logger.log("fetching owner shops");
    var event = await http.get('$API_URL/store?ownerId=$ownerId')
          .timeout(Duration(seconds: TIMEOUT_SEC));
          
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Order>> findOrdersByShopId(String id) async {
    logger.log("fetching all orders for shope with id $id");
    var event = await http.get('$API_URL/order?storeId=$id')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }

  Future<Order> progressOrderNextStage(String id) async {
    var event = await http.get('$API_URL/order/$id/nextstage')
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
        .post('$API_URL/device', headers: headers, body: request)
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
        .patch('$API_URL/device/${device.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) throw(ApiErrorResponse.fromJson(json.decode(event.body)).message);
    return event;
  }
}
