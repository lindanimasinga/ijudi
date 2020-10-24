import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class AllShopsViewModel extends BaseViewModel {
  List<Shop> _shops;
  List<Shop> _featuredShops = [];
  List<Advert> _ads = [];
  Set<String> filters = HashSet();
  String _search = "";
  bool notAvailMessageShown = false;
  var _radiusText;
  String locationDenied =
      "Location Services is not enabled. Showing shops and resturants within Durban region.";

  StreamSubscription<Position> locationStream;

  final ApiService apiService;
  final StorageManager storageManager;

  AllShopsViewModel({@required this.apiService, @required this.storageManager});

  get isLoggedIn => storageManager.isLoggedIn;

  @override
  void initialize() {
    _radiusText = Config.currentConfig.rangeMap.keys.first;
    log("showing all shops");
    locationStream = Rx.merge([
          getCurrentPosition(desiredAccuracy: LocationAccuracy.high).asStream(),
          getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)])
        .listen(null);

    locationStream.onData((position) => loadDataFromLastPosition(radiusText));
    locationStream.onError((e) {
      log(e.toString());
      if (e is PermissionDeniedException) {
        showError(error: locationDenied);
        loadDataFrom(
                Config.currentConfig.rangeMap[radiusText],
                Config.currentConfig.centreLatitude,
                Config.currentConfig.centrelongitude)
            .listen((event) {});
        return;
      }
    });
  }

  void loadDataFromLastPosition(String radius) {
    var range = Config.currentConfig.rangeMap[radiusText];
    log("fetching location ");
    var lastPositionStream = getLastKnownPosition();
    lastPositionStream.asStream().asyncExpand((position) {
      log("location is ${position.latitude} ${position.longitude}");
      return loadDataFrom(range, position.latitude, position.longitude);
    }).listen((resp) {}, onDone: () {}, onError: (e) {
      log(e.toString());
      if (e is PermissionDeniedException) {
        showError(error: locationDenied);
        return;
      }
    });
  }

  Stream loadDataFrom(double range, double latitude, double longitude) {
    return Rx.merge([
      apiService
          .findFeaturedShopByLocation(latitude, longitude, range, 20)
          .asStream()
          .map((resp) => featuredShops = resp),
      apiService
          .findAllShopByLocation(latitude, longitude, range, 20)
          .asStream()
          .map((resp) => shops = resp),
      apiService
          .findAllAdsByLocation(latitude, longitude, range, 20)
          .asStream()
          .map((resp) => ads = resp)
    ]);
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
    loadDataFromLastPosition(_radiusText);
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

  bool get showNoShopsAvailable {
    var show = shops != null && shops.isEmpty && !notAvailMessageShown;
    notAvailMessageShown = show || notAvailMessageShown;
    return show;
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
    log("Location stream disposed");
  }
}
