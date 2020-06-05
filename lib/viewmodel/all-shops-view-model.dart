import 'package:flutter/material.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class AllShopsViewModel extends BaseViewModel {

  List<Shop> _shops = [];
  List<Shop> _featuredShops = [];
  List<Advert> _ads = [];

  final ApiService apiService;

  AllShopsViewModel({@required this.apiService});
  
  @override
  void initialize() {
    Rx.merge([
      apiService.findFeaturedShopByLocation()
        .asStream()
        .map((resp) => featuredShops = resp),
      apiService.findAllShopByLocation()
        .asStream()
        .map((resp) => shops = resp),
      apiService.findAllAdsByLocation()
        .asStream()
        .map((resp) => ads = resp)
    ]).listen((resp) {

    }, onDone: () {
      
    }, onError: (e) {
      hasError = true;
      errorMessage = e.toString();
    });

  }

  addShop(Shop shop) {
    shops.add(shop);
    notifyChanged();
  }

  List<Shop> get featuredShops => _featuredShops;
  set featuredShops(List<Shop> featuredShops) {
    _featuredShops = featuredShops;
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