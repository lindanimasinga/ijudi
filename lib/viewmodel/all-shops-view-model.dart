import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  var _radiusText = '1500km';

  var rangeMap = {
    '10km' : 0.0666,
    '15km' : 0.1,
    '30km' : 0.2, 
    '1500km': 10.0
  };

  final ApiService apiService;

  AllShopsViewModel({@required this.apiService});

  @override
  void initialize() {
    loadData(radiusText);
  }

  void loadData(String radius) {
    var range = rangeMap[radiusText];
    log("fetching location ");
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .asStream()
        .asyncExpand((position) {
          log("location is ${position.latitude} ${position.longitude}");
          return Rx.merge([
            apiService
                .findFeaturedShopByLocation(position.latitude, position.longitude, range, 20)
                .asStream()
                .map((resp) => featuredShops = resp),
            apiService
                .findAllShopByLocation(position.latitude, position.longitude, range, 20)
                .asStream()
                .map((resp) => shops = resp),
            apiService.findAllAdsByLocation(position.latitude, position.longitude, range, 20)
                .asStream()
                .map((resp) => ads = resp)
          ]);
    }).listen((resp) {
      }, onDone: () {}, onError: (e) {
      log(e);
      hasError = true;
      errorMessage = e.toString();
    });
  }

  String get search => _search;
  set search(String search) {
    _search = search;
    notifyChanged();

    if (search.length > 3)
      BaseViewModel.analytics
          .logSearch(searchTerm: search)
          .then((value) => null);
  }

  get radiusText => _radiusText;
  set radiusText(radiusText) {
    _radiusText = radiusText;
    loadData(_radiusText);
    notifyChanged();
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
