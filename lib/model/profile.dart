import 'package:flutter/material.dart';

abstract class Profile {
  
  String id;
  String name;
  String description;
  int yearsInService;
  String address;
  String imageUrl;
  int likes;
  int servicesCompleted;
  int badges;
  String mobileNumber;
  String role;
  int responseTimeMinutes;
  String verificationCode;
  Bank bank;

  Profile(
      {@required this.name,
      @required this.description,
      @required this.yearsInService,
      @required this.address,
      @required this.imageUrl,
      this.likes,
      this.servicesCompleted,
      this.badges,
      this.verificationCode,
      @required this.mobileNumber,
      @required this.role,
      @required this.id, 
      @required this.bank});
}

class Bank {

  String name;
  String phone;
  String accountId;
  int customerId;
  String type;
  double currentBalance = 0;
  double availableBalance = 0;
  
  Bank({@required this.name,@required this.accountId,@required this.type,
   this.currentBalance, this.availableBalance, this.phone, this.customerId});
}
