import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/model/stock.dart';
import 'package:json_annotation/json_annotation.dart';

import 'business-hours.dart';

part 'shop.g.dart';

@JsonSerializable(includeIfNull: false)
class Shop extends Profile {
  
  String registrationNumber;
  List<BusinessHours> businessHours;
  List<Stock> stockList;
  Set<String> tags;
  bool hasVat;

  Shop(
      {@required String id,
      @required String name,
      this.registrationNumber,
      this.stockList,
      this.hasVat = false,
      this.tags,
      @required String description,
      @required int yearsInService,
      @required String address,
      @required String imageUrl,
      int likes,
      @required int servicesCompleted,
      int badges,
      String verificationCode,
      @required String mobileNumber,
      @required String role, 
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

  static Shop createPlaceHolder() {
        return Shop(
        id: "1",
        name: "......",
        registrationNumber: "",
        mobileNumber: "...........",
        description: "..............",
        address: "............",
        imageUrl: "https://pbs.twimg.com/media/C1OKE9QXgAAArDp.jpg",
        role: "Shop",
        yearsInService: 0,
        badges: 0,
        likes: 0,
        servicesCompleted: 0,
        bank: Bank(name: "Name", accountId: "Account", type: "Wallet"));
  } 
}
