import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

mixin TopTupStatusChecker {

    StreamSubscription checkTopUpSuccessul({
    @required int topUpId, int delay = 3}) {
    
    var subsc = _checkTopUpSuccessul(topUpId: topUpId, delay: delay)
    .listen((event) {
    });

    subsc.onDone(() {
      //progressMv.isBusy = false;
    });

    subsc.onError((e) {
      showError(messege: e.toString());
      BaseViewModel.analytics
      .logEvent(name: "ukheshe-topup-loading-webview-error")
      .then((value) => {});
    });
    return subsc;
  }

  Stream<InitTopUpResponse> _checkTopUpSuccessul({
    @required int topUpId, int delay = 3, timeout = 300}) {
    
    return Future.delayed(Duration(seconds: delay)).asStream()
    .asyncExpand((event) => ukhesheService.getTopUp(topUpId).asStream())
    .asyncExpand((data) {
      log("checking if topup $topUpId status is ${data.status}");
      if(timeout == 0 || data.status == "ERROR_PERM" || 
        data.status == "TIMEOUT") {
          throw("${data.status} Please try again.");
      }
      return data.status == "PENDING" || data.status == "ERROR_TEMP" || data.status == "UPDATING"?
       _checkTopUpSuccessul(topUpId: topUpId, timeout: timeout - 3) : Stream.value(data);
    });
  }

  get ukhesheService;

  showError({String messege});
}