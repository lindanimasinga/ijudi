import 'dart:collection';

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
  Set<String> filters = HashSet();
  String _search = "";

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

  String get search => _search;
  set search(String search) {
    _search = search;
    notifyChanged();

    if(search.length > 3)
    BaseViewModel.analytics
    .logSearch(searchTerm: search)
    .then((value) => null);
  }

  addShop(Shop shop) {
    shops.add(shop);
    notifyChanged();
  }

  List<Shop> get featuredShops => _featuredShops;
  set featuredShops(List<Shop> featuredShops) {
    _featuredShops = featuredShops;
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

  void removeFilter(String filterName) {
    filters.remove(filterName);
    notifyChanged();
  }

  void addFilter(String filterName) {
    filters.add(filterName);
    notifyChanged();
  }

}