import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ijudi/model/supported-location.dart';
import 'package:ijudi/view/all-shops-view.dart';

import 'base-view-model.dart';

class ChooseLocationViewModel extends BaseViewModel {
  SupportedLocation? _supportedLocation;

  SupportedLocation? get supportedLocation => _supportedLocation;

  set supportedLocation(supportedLocation) {
    _supportedLocation = supportedLocation;
    notifyChanged();
  }

  viewShops() {
    if (supportedLocation != null) {
      progressMv!.isBusy = true;
      Navigator.pushNamedAndRemoveUntil(
          context, AllShopsView.ROUTE_NAME, (Route<dynamic> route) => false,
          arguments: supportedLocation);
    }
  }
}
