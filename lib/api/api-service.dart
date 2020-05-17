import 'dart:math';

import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/userProfile.dart';

class ApiService {
  static List<Shop> findAllShopByLocation() {
    List<Shop> shops = [
      Shop(
          imageUrl:
              "https://www.dailymaverick.co.za/wp-content/uploads/BM-Ruan-spaza-main-1600x870.jpg",
          id: "1",
          name: "Sheila's TuckShop",
          registrationNumber: "20170098087",
          mobileNumber: "0813114112",
          description: "Sells Veggies, Fruits, Drinks",
          address: "BB Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 5,
          badges: 2,
          likes: 35,
          servicesCompleted: 350,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
      Shop(
          name: "Spar",
          description: "Sells veggies, meat, airtime and electricity.",
          imageUrl:
              "https://richesworld.bid/wp-content/uploads/2019/03/home1.png",
          id: "1",
          registrationNumber: "20170098087",
          mobileNumber: "0713134112",
          address: "U Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 7,
          badges: 5,
          likes: 20,
          servicesCompleted: 850,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
      Shop(
          name: "Sbonelo Tuckshop",
          description: "Sells veggies, fruits, airtime and electricity.",
          imageUrl:
              "https://gga.org/wp-content/uploads/2018/02/2017-04-27-14.42.12-1080x675.jpg",
          id: "1",
          registrationNumber: "20170098087",
          mobileNumber: "0813114112",
          address: "BB Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 3,
          badges: 1,
          likes: 20,
          servicesCompleted: 150,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
      Shop(
          name: "Mthembeni Tuckshop",
          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRLhCGtBvdID_7ysGxYzHc9QtG3Fjl_uVutkvO2-PDqRxvyXhAC&usqp=CAU",
          id: "1",
          registrationNumber: "20170098087",
          mobileNumber: "0813114112",
          description: "Sells Veggies, Fruits, Drinks",
          address: "BB Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 10,
          badges: 0,
          likes: 3,
          servicesCompleted: 50,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
      Shop(
          name: "Boxer Store",
          imageUrl:
              "https://www.boxer.co.za/wp-content/uploads/2018/04/Boxer-Stores.jpg",
          id: "1",
          registrationNumber: "20170098087",
          mobileNumber: "0813114112",
          description: "Sells Veggies, Fruits, Drinks",
          address: "BB Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 10,
          badges: 0,
          likes: 3,
          servicesCompleted: 50,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
      Shop(
          name: "Chester Butchery",
          imageUrl: "https://pbs.twimg.com/media/BeFonWZCYAAi9BJ.jpg",
          id: "1",
          registrationNumber: "20170098087",
          mobileNumber: "0813114112",
          description: "Sells Veggies, Fruits, Drinks",
          address: "BB Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 10,
          badges: 0,
          likes: 3,
          servicesCompleted: 50,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
      Shop(
          name: "Themba Fastfood",
          imageUrl:
              "https://cdn.24.co.za/files/Cms/General/d/4968/485b8622d96b49be8df4977f58522f19.jpg",
          id: "1",
          registrationNumber: "20170098087",
          mobileNumber: "0813114112",
          description: "Sells Veggies, Fruits, Drinks",
          address: "BB Umlazi, Durban, KZN",
          role: "Shop",
          yearsInService: 10,
          badges: 0,
          likes: 3,
          servicesCompleted: 50,
          bank: Bank(name: "FNB", accountId: "2885091160", type: "Cheque")),
    ];
    return shops;
  }

  static Stream<List<Stock>> findAllStockByShopId(String s) {
    List<Stock> stock = [
      Stock(
        name: "Eggs",
        quantity: 20,
        price: 00.00,
      ),
      Stock(name: "Bread", quantity: 50, price: 35.00),
      Stock(name: "Banana", quantity: 20, price: 10.50),
      Stock(name: "Eggs 6", quantity: 20, price: 0.00),
      Stock(name: "Airtime", quantity: 20, price: 16.00),
      Stock(name: "Banana", quantity: 20, price: 10.50),
      Stock(name: "Eggs 6", quantity: 20, price: 0.00)
    ];
    return Stream.value(stock);
  }

  static Shop findShopById(String s) {
    Shop shop = Shop(
        id: "1",
        name: "Sheila's TuckShop",
        registrationNumber: "20170098087",
        mobileNumber: "0813114112",
        description: "Sells Veggies, Fruits, Drinks",
        address: "BB Umlazi, Durban, KZN",
        imageUrl: "https://zbinworld.com/wp-content/uploads/2017/09/spaza.jpg",
        role: "Shop",
        yearsInService: 3,
        badges: 1,
        likes: 20,
        servicesCompleted: 150,
        bank: Bank(name: "Ukheshe", accountId: "2885091160", type: "Wallet"));

    return shop;
  }

  static Profile findUserById(String s) {
    UserProfile profile = UserProfile(
        id: "1",
        name: "Thabani Mlotshwa",
        idNumber: "8909126118083",
        mobileNumber: "0815114442",
        description: "Deliveries and errands",
        address: "BB Umlazi, Durban, KZN",
        imageUrl:
            "https://webcomicms.net/sites/default/files/clipart/146130/black-women-cliparts-146130-7812411.jpg",
        role: "Shop",
        yearsInService: 3,
        badges: 1,
        likes: 20,
        servicesCompleted: 150,
        bank: Bank(
            name: "Ukhese",
            accountId: "2885091160",
            type: "Wallet",
            phone: "0812815707",
            currentBalance: 0.00,
            availableBalance: 0.00));

    return profile;
  }

  static List<UserProfile> findNearbyMessangers(String s) {
    var messagers = <UserProfile>[];

    var messager1 = findUserById("");
    messager1.name = "Sandile Ngema";
    messager1.likes = 12;
    messager1.responseTimeMinutes = 2 + Random().nextInt(13);
    messager1.imageUrl =
        "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/man-raising-hand-medium-dark-skin-tone.png";
    messagers.add(messager1);

    var messager2 = findUserById("");
    messager2.name = "Xolani Shezi";
    messager2.likes = 12;
    messager2.responseTimeMinutes = 2 + Random().nextInt(13);
    messager2.imageUrl =
        "https://i.pinimg.com/236x/5b/11/99/5b1199b7336b689439563863d8b911e1--black-fathers-father-christmas.jpg";
    messagers.add(messager2);

    return messagers;
  }

  static Stream<dynamic> registerUser(UserProfile user) {
    return Future.delayed(Duration(seconds: 2)).asStream();
  }

  static Stream<dynamic> verifyCanBuy(Busket busket) {
    return Future.delayed(Duration(seconds: 2)).asStream();
  }

  static findAllAdsByLocation() {
    return <Advert>[
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
    ];
  }

  static Stream<String> updateShop(Shop shop) {
    return Future.delayed(Duration(seconds: 2))
      .asStream()
      .map((resp) => "200");
  }

  static Stream<String> addStockItem(String id, Stock stock) {
    return Future.delayed(Duration(seconds: 2))
      .asStream()
      .map((resp) => "200");
  }

  static Stream<Order> startOrder(Order order) {
    return  Future.delayed(Duration(seconds: 2)).asStream()
              .map((re) => order);
  }
}
