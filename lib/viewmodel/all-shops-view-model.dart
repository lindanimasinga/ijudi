import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/config.dart';
import 'package:ijudi/model/advert.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/supported-location.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:rxdart/rxdart.dart';

class AllShopsViewModel extends BaseViewModel {
  List<Shop> _featuredShops = [];
  List<Advert> _ads = [];
  Set<String> filters = HashSet();
  String _search = "";
  bool notAvailMessageShown = false;
  bool _loadingFailed = false;
  List<Shop>? _shops = null;

  var _radiusText;
  String locationDenied =
      "Location Services is not enabled. Showing shops and resturants within Durban region.";

  final ApiService apiService;
  final StorageManager? storageManager;
  final SupportedLocation? supportedLocation;

  AllShopsViewModel(
      {required this.supportedLocation,
      required this.apiService,
      required this.storageManager});

  get isLoggedIn => storageManager!.isLoggedIn;

  @override
  void initialize() {
    radiusText = Config.currentConfig!.rangeMap.keys.first;
    log("showing all shops");
    loadDataFromLastPosition(radiusText);
  }

  bool get loadingFailed => _loadingFailed;

  set loadingFailed(bool loadingFailed) {
    _loadingFailed = loadingFailed;
    notifyChanged();
  }

  get dataAvailable {
    return shops != null;
  }

  void loadDataFromLastPosition(String? radius) {
    var range = Config.currentConfig!.rangeMap[radiusText];
    log("location is ${supportedLocation!.latitude} ${supportedLocation!.longitude}");
    loadDataFrom(
            range, supportedLocation!.latitude, supportedLocation!.longitude)
        .listen((data) {});
  }

  Stream loadDataFrom(double? range, double latitude, double longitude) {
    loadingFailed = false;
    return Rx.merge([
      apiService
          .findAllShopByLocation(latitude, longitude, range, 20)
          .asStream()
          .doOnError((p0, p1) => loadingFailed = true)
          .map((resp) {
        print("shops response received.");
        groupShopsIntoFranchises(resp);
      }),
      apiService
          .findFeaturedShopByLocation(latitude, longitude, range, 20)
          .asStream()
          .map((resp) => groupFeaturedShopsIntoFranchises(resp)),
      apiService
          .findAllAdsByLocation(latitude, longitude, range, 20)
          .asStream()
          .map((resp) => ads = resp),
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
    shops!.add(shop);
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

  List<Shop>? get shops => _shops;
  set shops(List<Shop>? shops) {
    _shops = shops;
    notifyChanged();
  }

  bool get showNoShopsAvailable {
    var show = shops != null && shops!.isEmpty == true && !notAvailMessageShown;
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
  }

  void groupShopsIntoFranchises(List<Shop> resp) {
    shops = [];
    resp.forEach((itemToAdd) {
      //if franchise not added yet
      var sameShops = shops
          ?.where((addedShop) =>
              itemToAdd.franchiseName != null &&
              addedShop.franchiseName == itemToAdd.franchiseName)
          .toList();

      sameShops?.forEach((franchise) {
        if (franchise.franchises == null) {
          franchise.franchises = [];
        }
        franchise.franchises?.add(itemToAdd);
      });

      if (sameShops == null || sameShops.isEmpty) {
        shops?.add(itemToAdd);
      }
    });
  }

  void groupFeaturedShopsIntoFranchises(List<Shop> resp) {
    featuredShops = [];
    print("feashop shops is ${featuredShops.length}");
    resp.forEach((itemToAdd) {
      //if franchise not added yet
      var sameShops = featuredShops
          .where((addedShop) =>
              itemToAdd.franchiseName != null &&
              addedShop.franchiseName == itemToAdd.franchiseName)
          .toList();

      sameShops.forEach((franchise) {
        if (franchise.franchises == null) {
          franchise.franchises = [];
        }
        franchise.franchises?.add(itemToAdd);
      });

      if (sameShops.isEmpty) {
        if (itemToAdd.franchises == null && shops != null) {
          itemToAdd.franchises = [];
          var sameNonFeaturedShops = shops?.where((item) =>
              item.franchiseName == itemToAdd.franchiseName &&
              item.name != itemToAdd.name);
          if (sameNonFeaturedShops != null) {
            itemToAdd.franchises?.addAll(sameNonFeaturedShops);
          }
        }
        featuredShops.add(itemToAdd);
      }
    });
  }
}
