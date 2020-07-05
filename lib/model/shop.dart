import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/stock.dart';
import 'package:ijudi/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'business-hours.dart';

part 'shop.g.dart';

@JsonSerializable(includeIfNull: false)
class Shop extends Profile {
  
  String registrationNumber;
  @JsonKey(ignore: false, toJson: businessHoursToJson)
  List<BusinessHours> businessHours;
  @JsonKey(ignore: false, toJson: listToJson)
  List<Stock> stockList;
  Set<String> tags;
  bool hasVat;
  String ownerId;
  bool featured;
  @JsonKey(fromJson: Utils.dateFromJson, toJson: Utils.dateToJson)
  DateTime featuredExpiry;
  double latitude;
  double longitude;

  Shop(
      {@required String id,
      @required String name,
      this.registrationNumber,
      this.stockList,
      this.hasVat = false,
      this.tags,
      this.featured,
      this.featuredExpiry,
      @required String description,
      @required int yearsInService,
      @required String address,
      @required String imageUrl,
      int likes,
      @required int servicesCompleted,
      int badges,
      String verificationCode,
      @required String mobileNumber,
      @required ProfileRoles role,
      @required Bank bank})
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
            role: role,
            bank: bank);

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);

  static List<Map<String,dynamic>> listToJson(List<Stock> list) {
    print("converting to json 1");
    var jsonString = list.map((f) => f.toJson())
      .toList();
    log(json.encode(jsonString[0]));
    return jsonString;  
  }

  static List<String> setToJson(Set<String> list) {
    print("converting to json 1");
    var jsonString = list.map((f) => "Map()")
      .toList();
    print(jsonString);
    return jsonString;  
  }

  static List<Map<String,dynamic>> businessHoursToJson(List<BusinessHours> list) {
    print("converting to json 2");
    var jsonString = list.map((f) => f.toJson()).toList();
    print("converting to json 2 passed");
    print(jsonString);
    return jsonString;  
  }

  bool containsStockItem(String search) {
    var list = stockList
    .where((element) => element.name.toLowerCase().contains(search.toLowerCase()))
    .toList();
    return list != null && list.length > 0;
  }
}
