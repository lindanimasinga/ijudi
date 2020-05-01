import 'package:flutter/material.dart';
import 'package:ijudi/model/profile.dart';

class UserProfile extends Profile {
  
  String idNumber;

  UserProfile(
      {@required String id,
      @required String name,
      @required this.idNumber,
      @required String description,
      int yearsInService,
      String address,
      @required String imageUrl,
      int likes,
      int servicesCompleted,
      int badges,
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
            role: role,
            bank: bank);
}
