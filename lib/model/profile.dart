import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

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
  Bank bank = Bank();

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

@JsonSerializable(includeIfNull: false)
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


  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BankToJson(this); 
}
