import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class AllShopsViewModel extends BaseViewModel {

  List<Shop> _shops = [];
  List<Advert> _ads = [];

  final ApiService apiService;

  AllShopsViewModel({@required this.apiService});
  
  @override
  void initialize() {
    Rx.merge([
      apiService.findAllShopByLocation()
        .asStream()
        .map((resp) => shops = resp),
      apiService.findAllAdsByLocation()
        .asStream()
        .map((resp) => ads = resp)
    ]).listen((resp) {

    }, onDone: () {
      
    });

  }

  addShop(Shop shop) {
    shops.add(shop);
    notifyChanged();
  }

  List<Advert> get ads => _ads;

  set ads(List<Advert> ads) {
    _ads = ads;
    notifyChanged();
  }

  List<Shop> get shops => _shops;

  set shops(List<Shop> shops) {
    _shops = shops;
    notifyChanged();
  }



}