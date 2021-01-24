import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ijudi/api/ukheshe/model/cards-on-file.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

mixin TopTupStatusChecker {
  Bank _wallet = Bank();

  List<CardsOnFile> paymentCards;
  InitTopUpResponse cardlinkingResponse;
  String topupAmount;

  UkhesheService get ukhesheService;
  Bank get wallet => _wallet;
  set wallet(Bank wallet) {
    _wallet = wallet;
    notifyChanged();
      }
    
      get hasCards => paymentCards != null && paymentCards.length <= 0;
    
      StreamSubscription checkTopUpSuccessul(
          {@required int topUpId, int delay = 3}) {
        var subsc =
            _checkTopUpSuccessul(topUpId: topUpId, delay: delay).listen((event) {});
    
        subsc.onDone(() {
          //progressMv.isBusy = false;
        });
    
        subsc.onError((e) {
          showError(error: e);
          BaseViewModel.analytics.logEvent(
              name: "error.ukheshe.topup.loading.webview",
              parameters: {"error": e.toString()}).then((value) => {});
        });
        return subsc;
      }
    
      Stream<InitTopUpResponse> _checkTopUpSuccessul(
          {@required int topUpId, int delay = 3, timeout = 300}) {
        return Future.delayed(Duration(seconds: delay))
            .asStream()
            .asyncExpand((event) => ukhesheService.getTopUp(topUpId).asStream())
            .asyncExpand((data) {
          log("checking if topup $topUpId status is ${data.status}");
          if (timeout == 0 ||
              data.status == "ERROR_PERM" ||
              data.status == "TIMEOUT") {
            throw ("${data.status} Please try again.");
          }
          return data.status == "PENDING" ||
                  data.status == "ERROR_TEMP" ||
                  data.status == "UPDATING"
              ? _checkTopUpSuccessul(topUpId: topUpId, timeout: timeout - 3)
              : Stream.value(data);
        });
      }
    
      StreamSubscription<InitTopUpResponse> topUp() {
        //progressMv.isBusy = true;
        var sub = ukhesheService
            .initiateTopUp(wallet.customerId, double.parse(topupAmount), null,
                paymentCards.first)
            .asStream()
            .listen(null);
    
        sub.onDone(() {
          //progressMv.isBusy = false;
        });
    
        sub.onError((e) {
          showError(error: e);
          BaseViewModel.analytics.logEvent(
              name: "error.ukheshe.topup.loading.webview",
              parameters: {"error": e.toString()}).then((value) => {});
        });
        return sub;
      }
    
      generateAddPaymentCardUrl() {
        //progressMv.isBusy = true;
        var sub = ukhesheService
            .addCardsOnFile(wallet.customerId)
            .asStream()
            .listen(null);
        sub.onDone(() {
          //progressMv.isBusy = false;
        });
    
        sub.onData((data) {
          this.cardlinkingResponse = data;
        });
    
        sub.onError((e) {
          showError(error: e);
          BaseViewModel.analytics.logEvent(
              name: "error.ukheshe.topup.loading.webview",
              parameters: {"error": e.toString()}).then((value) => {});
        });
      }
    
      StreamSubscription<List<CardsOnFile>> fetchPaymentCards() {
        //progressMv.isBusy = true;
        var sub = ukhesheService
            .fetchCardsOnFile(wallet.customerId)
            .asStream()
            .map((event) => this.paymentCards = event)
            .listen(null);
        sub.onDone(() {
          //progressMv.isBusy = false;
        });
    
        sub.onError((e) {
          showError(error: e);
          BaseViewModel.analytics.logEvent(
              name: "error.ukheshe.topup.loading.webview",
              parameters: {"error": e.toString()}).then((value) => {});
        });
    
        return sub;
      }
    
      fetchNewAccountBalances() {
        //progressMv.isBusy = true;
        ukhesheService.getAccountInformation().asStream().listen((resp) {
          wallet = resp;
        }, onError: (e) {
          showError(error: e);
        }, onDone: () {
          // progressMv.isBusy = false;
        });
      }
    
      showError({dynamic error});
    
      void notifyChanged();
}
