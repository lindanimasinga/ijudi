import 'dart:convert';
import 'dart:developer';

import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/model/store-messenger.dart';
import 'package:ijudi/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'business-hours.dart';
import 'geo-location.dart';

part 'shop.g.dart';

@JsonSerializable(includeIfNull: false)
class Shop extends Profile with GeoLocation {
  String storeType;
  String? registrationNumber;
  @JsonKey(ignore: false, toJson: businessHoursToJson)
  List<BusinessHours> businessHours;
  @JsonKey(ignore: false, toJson: listToJson)
  List<Stock> stockList;
  Set<String>? tags;
  bool? hasVat;
  bool scheduledDeliveryAllowed;
  bool deliverNowAllowed;
  String? ownerId;
  bool featured;
  bool markUpPrice;
  @JsonKey(fromJson: Utils.dateFromJson, toJson: Utils.dateToJson)
  DateTime? featuredExpiry;
  List<StoreMessenger>? storeMessenger;
  bool storeOffline;
  String? availability;
  String? shortName;
  String? franchiseName;
  List<Shop>? franchises;

  Shop(
      {required String id,
      required String name,
      this.registrationNumber,
      required this.stockList,
      this.hasVat = false,
      this.scheduledDeliveryAllowed = false,
      this.deliverNowAllowed = true,
      required this.tags,
      required this.featured,
      required this.ownerId,
      required this.businessHours,
      this.featuredExpiry,
      required this.storeOffline,
      required this.availability,
      this.markUpPrice = true,
      this.shortName,
      required this.storeType,
      required String? description,
      required int? yearsInService,
      required String? address,
      required String? imageUrl,
      double? latitude,
      double? longitude,
      int? likes,
      required int? servicesCompleted,
      int? badges,
      String? verificationCode,
      required String? mobileNumber,
      required ProfileRoles? role,
      this.franchiseName,
      required Bank? bank})
      : super(
            id: id,
            name: name,
            description: description,
            yearsInService: yearsInService,
            address: address,
            imageUrl: imageUrl,
            likes: likes,
            servicesCompleted: servicesCompleted,
            badges: badges,
            mobileNumber: mobileNumber,
            verificationCode: verificationCode,
            latitude: latitude,
            longitude: longitude,
            role: role,
            bank: bank);

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);

  static List<Map<String, dynamic>> listToJson(List<Stock> list) {
    print("converting to json 1");
    var jsonString = list.map((f) => f.toJson()).toList();
    log(json.encode(jsonString[0]));
    return jsonString;
  }

  static List<String> setToJson(Set<String> list) {
    print("converting to json 1");
    var jsonString = list.map((f) => "Map()").toList();
    print(jsonString);
    return jsonString;
  }

  static List<Map<String, dynamic>> businessHoursToJson(
      List<BusinessHours?> list) {
    print("converting to json 2");
    var jsonString = list.map((f) => f!.toJson()).toList();
    print("converting to json 2 passed");
    print(jsonString);
    return jsonString;
  }

  bool containsStockItem(String search) {
    var list = stockList
        .where((element) =>
            element.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    return list.length > 0;
  }
}
