import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ijudi/model/supported-location.dart';
import 'package:ijudi/view/all-shops-view.dart';

import 'base-view-model.dart';

class ChooseLocationViewModel extends BaseViewModel {
  var _deliveryAddress;

  get deliveryAddress => _deliveryAddress;

  set deliveryAddress(deliveryAddress) {
    _deliveryAddress = deliveryAddress;
    notifyChanged();
  }

  viewShops() {
    progressMv!.isBusy = true;
    locationFromAddress(deliveryAddress).asStream().listen((location) {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(
            context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false,
            arguments: SupportedLocation("Change Location",
                location[0].latitude, location[0].longitude));
      });
    }, onDone: () {
      progressMv!.isBusy = false;
    });
  }
}
