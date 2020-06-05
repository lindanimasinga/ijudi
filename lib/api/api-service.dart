import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/basket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/userProfile.dart';
import 'package:ijudi/services/storage-manager.dart';

class ApiService {

  static const API_URL = "http://ec2co-ecsel-1b20jvvw3yfzt-2104564802.af-south-1.elb.amazonaws.com/";
  static const TIMEOUT_SEC = 20;
  static UserProfile currentUser;
  final StorageManager storageManager;

  ApiService(this.storageManager);

  get currentUserPhone => storageManager.mobileNumber;
  
  Future<List<Shop>> findAllShopByLocation() async {
    logger.log("fetching all shops");
    var event = await http.get('$API_URL/store')
        .timeout(Duration(seconds: TIMEOUT_SEC));

    if(event.statusCode != 200) throw(event.body);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Shop.fromJson(f)).toList();
  }

    Future<List<Shop>> findFeaturedShopByLocation() async {
      logger.log("fetching fetured shops");
      var event = await http.get('$API_URL/store?featured=true')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(event.body);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Shop.fromJson(f)).toList();
  }

  Future<List<Stock>> findAllStockByShopId(String id) async {

    logger.log("fetching stock shops");
      var event = await http.get('$API_URL/store/$id/stock')
          .timeout(Duration(seconds: TIMEOUT_SEC));

      if(event.statusCode != 200) throw(event.body);     
      
      Iterable list = json.decode(event.body);
      return list.map((f) => Stock.fromJson(f)).toList();
  }

  Future<Shop> findShopById(String id) async {
    logger.log("fetching fetured shops");
    var event = await http.get('$API_URL/store/$id')
          .timeout(Duration(seconds: TIMEOUT_SEC));
          
    if(event.statusCode != 200) throw(event.body);     
  
    return Shop.fromJson(json.decode(event.body));
  }

  Future<UserProfile> findUserByPhone(String phone) async {
    if(currentUser != null) {
      return Future.value(currentUser);
    }

    var event = await http.get('$API_URL/user?phone=$phone')
            .timeout(Duration(seconds: TIMEOUT_SEC));
    if(event.statusCode != 200) {
      logger.log(event.statusCode.toString());
      logger.log(event.body);
      throw(event);
    }       
    
    currentUser = UserProfile.fromJson(json.decode(event.body));
    return currentUser;
  }

  Future<List<UserProfile>> findNearbyMessangers(String s) async {
    var messagers = <UserProfile>[];

    var messager1 = await findUserByPhone("");
    messager1.name = "Sandile Ngema";
    messager1.likes = 12;
    messager1.responseTimeMinutes = 2 + Random().nextInt(13);
    messager1.imageUrl =
        "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/man-raising-hand-medium-dark-skin-tone.png";
    messagers.add(messager1);

    var messager2 = await findUserByPhone("");
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
    if(event.statusCode != 200) throw(event);
    user = UserProfile.fromJson(json.decode(event.body));
    storageManager.saveIjudiUserId(user.id);
    return event;
  }

  Future<dynamic> verifyCanBuy(Basket basket) async {
    return Future.delayed(Duration(seconds: 2)).asStream();
  }

  Future<List<Advert>> findAllAdsByLocation() async {
    return Future.value(<Advert>[
      Advert(
        imageUrl:
            "https://www.foodinaminute.co.nz/var/fiam/storage/images/recipes/mexican-bean-and-corn-pies/7314837-14-eng-US/Mexican-Bean-and-Corn-Pies_recipeimage.jpg",
      ),
      Advert(
        imageUrl:
            "https://sowetourban.co.za/wp-content/uploads/sites/112/2018/08/IMG_4251_27897_tn-520x400.jpg",
      ),
      Advert(
        imageUrl:
            "https://snapsizzleandcook.co.za/wp-content/uploads/2018/07/images1.jpg",
      ),
      Advert(
        imageUrl:
            "https://i.pinimg.com/236x/76/ab/66/76ab66a5e774d4deaf21ce7c02806a32--the-ad-advertising-design.jpg",
      )
    ]);
  }

  Future<String> updateShop(Shop shop) async {
    return Future.delayed(Duration(seconds: 2));
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

    if(event.statusCode != 200) throw(event.body);     

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
    if(event.statusCode != 200) throw(event);
    return Order.fromJson(json.decode(event.body));
  }

  Future<Order> completeOrderPayment(Order order) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var request = json.encode(order);
    print(request);
    var event = await http
        .patch('$API_URL/order/${order.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log("Try 1");
    logger.log(event.body);

    if(event.statusCode != 200){
       event = await http
        .patch('$API_URL/order/${order.id}', headers: headers, body: request)
        .timeout(Duration(seconds: TIMEOUT_SEC));
      logger.log("Try 2");
      logger.log(event.body);
    }

    if(event.statusCode != 200) throw(event);
    return Order.fromJson(json.decode(event.body));
  }

  Future<List<Order>> findOrdersByPhoneNumber(String phone) async {
    logger.log("fetching all orders for customer phone number $phone");
    var event = await http.get('$API_URL/order?phone=$phone')
        .timeout(Duration(seconds: TIMEOUT_SEC));
    logger.log(event.body);
    if(event.statusCode != 200) throw(event);     
        
    Iterable list = json.decode(event.body);
    return list.map((f) => Order.fromJson(f)).toList();
  }
}
