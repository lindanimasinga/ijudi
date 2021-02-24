import 'package:ijudi/api/api-service.dart';
import 'package:ijudi/api/ukheshe/ukheshe-service.dart';
import 'package:ijudi/util/topup-status-checker.dart';
import 'package:ijudi/viewmodel/base-view-model.dart';

class WalletViewModel extends BaseViewModel with TopTupStatusChecker {
  final ApiService apiService;
  final UkhesheService ukhesheService;

  String about =
      "Telkom Pay is a digital wallet that lets you send and received money without a need to have a" +
          "bank account.\n\nIt simple requires only your mobile number and you are good to go." +
          "You can send, receive and withdraw and deposit money from any ATM or Pick n Pay stores";

  String depositNWithdraw =
      "To withdraw money from your Telkom Pay card, simply generate a cash token via USSD by dialling *120*82274# and select option 1. Alternatively, if you have a smartphone you can use the app to generate a token. Then simply visit your nearest Pick n Pay till point and present them with your Reference Number (it starts with the number 1 e.g. 196792876).";
  String visitUrl = "https://apps.telkom.co.za/today/shop/plan/telkom-pay-digital-wallet";
  String topupAmount = "0";
  bool notFicadShown = false;

  WalletViewModel({this.apiService, this.ukhesheService});

  @override
  initialize() {
    this.ukhesheService.getAccountInformation().asStream().listen((data) {
      this.wallet = data;
      fetchPaymentCards().onData((data) {
        this.paymentCards = data;
        this.paymentCardselected = data.first;
      });
      generateAddPaymentCardUrl();
    }, onError: (e) {
      showError(error: e);
    });
  }

  String get baseUrl => ukhesheService.baseUrl;
}
