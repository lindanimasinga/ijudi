import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/util/util.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class AllShopsViewModel extends BaseViewModel {
  List<Shop> _shops = [];
  List<Shop> _featuredShops = [];
  List<Advert> _ads = [];
  Set<String> filters = HashSet();
  String _search = "";
  var _radiusText = '16500km';

  var geolocator = Geolocator();
  StreamSubscription locationStream;


  final ApiService apiService;

  AllShopsViewModel({@required this.apiService});

  @override
  void initialize() {
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high, 
        distanceFilter: 10);
    //use last known location
    //listen for location changes  
    locationStream = geolocator.getLastKnownPosition().asStream()
    .map((position) => loadData(radiusText))
        .asyncExpand((event) => geolocator.getPositionStream(locationOptions))
        .listen((position) => loadData(radiusText)
        , onDone: () {}, 
        onError: (e) {
          log(e.toString());
          if(e is PlatformException) {
            loadData(radiusText);
            return;
          }
          hasError = true;
          errorMessage = e.toString();
        });
  }

  void loadData(String radius) {
    var range = Utils.rangeMap[radiusText];
    log("fetching location ");
    var lastPositionStream = geolocator.getLastKnownPosition();
    lastPositionStream.asStream()
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
      log(e.toString());
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

  @override
  void dispose() {
    super.dispose();
    locationStream.cancel();
  }
}
