import 'dart:async';

import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/util/topup-status-checker.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';
import 'package:ijudi/model/profile.dart';

class WalletViewModel extends BaseViewModel with TopTupStatusChecker {

  final ApiService apiService;
  final UkhesheService ukhesheService;

  Bank _wallet = Bank();

  String about = "Ukheshe is a digital wallet that lets you send and received money without a need to have a"+ 
                      "bank account.\n\nIt simple requires only your mobile number and you are good to go." +
                      "You can send, receive and withdraw and deposit money from any ATM or Pick n Pay stores";

  String depositNWithdraw = "To withdraw money from your uKheshe card, simply generate a cash token via USSD by dialling *120*82274# and select option 1. Alternatively, if you have a smartphone you can use the app to generate a token. Then simply visit your nearest Pick n Pay till point and present them with your Reference Number (it starts with the number 1 e.g. 196792876).";
  String visitUrl = "https://www.ukheshe.co.za";
  String topupAmount = "0";            
                    

  WalletViewModel({this.apiService, this.ukhesheService});

  @override
  initialize() {
    this.ukhesheService.getAccountInformation()
      .asStream()
      .listen((data) {
        this.wallet = data;
      },onError: (e) {
        showError(error: e);
      });
  }

  Bank get wallet => _wallet;
  set wallet(Bank wallet) {
    _wallet = wallet;
    notifyChanged();
  }

  String get baseUrl => ukhesheService.baseUrl;

  StreamSubscription<InitTopUpResponse> topUp() {
    //progressMv.isBusy = true;
    var sub  = ukhesheService
        .initiateTopUp(wallet.customerId, double.parse(topupAmount), null)
        .asStream()
        .listen(null);
    sub.onDone(() {
      //progressMv.isBusy = false;
    });

    sub.onError((e) {
      showError(error: e);
      
      BaseViewModel.analytics
      .logEvent(name: "error.ukheshe.topup.loading.webview", 
        parameters: {
        "error" : e.toString()
        }
      )
      .then((value) => {});

    });

    return sub;    
  }

  fetchNewAccountBalances() {
    //progressMv.isBusy = true;
    ukhesheService.getAccountInformation()
      .asStream()
      .listen((resp) {
        wallet = resp;
      },onError: (e) {
      showError(error: e);
      },
      onDone: () {
       // progressMv.isBusy = false;
      });
  }
}