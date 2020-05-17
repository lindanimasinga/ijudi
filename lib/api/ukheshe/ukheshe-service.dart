
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/model/jwt-response.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:intl/intl.dart';
import 'model/payment-response.dart';

class UkhesheService {
  
  static const TIMEOUT_SEC = 20;
  static String baseURL = "https://ukheshe-sandbox.jini.rocks";
  static String apiUrl = "$baseURL/ukheshe-conductor/rest/v1";
  static Map<String, String> headers = {"Content-Type": "application/json"};
  
  final StorageManager storageManager;

  UkhesheService(this.storageManager);

  Stream<JWTResponse> authenticate(String username, String password) {
    
    var request = {"identity": username, "password": password};
    print("authenticating");
    return http
        .post('$apiUrl/login', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC))
        .asStream()
        .map((data) =>
          data.statusCode != 200? throw(data.body) :
          JWTResponse.fromJson(json.decode(data.body))
        ).map((data) {
          storageManager.saveUkhesheAccessToken(data.headerValue);
          return data;
        });
  }

  bool get isLoggedIn => storageManager.findUkhesheAccessToken() != null;

  Stream<PaymentResponse> paymentForOrder(Order order) {

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
    }; 

    var request = {
      "fromAccountId": order.busket.customer.bank.accountId,
      "toAccountId": order.busket.shop.bank.accountId,
      "type": "MANUAL_APP",
      "amount": order.totalAmount,
      "description": "Payment from ${order.customer.mobileNumber}: order ${order.id}",
      "uniqueId": order.id,
      "externalId": order.id,
      "date": new DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(order.date),
      "message": "Pay for order ${order.id}"
    };

    print(headers);
    print(json.encode(request));

    return http
        .post('$apiUrl/transfers', headers: headers, body: json.encode(request))
        .asStream()
        .timeout(Duration(seconds: TIMEOUT_SEC))
        .map((data) {
          print("response " + data.statusCode.toString());
          return data.statusCode == 200 ? 
                  PaymentResponse.fromJson(json.decode(data.body)) : throw(data);}
        );
  }

  Stream registerUkhesheAccount(Bank bank, String otp, String password) {
    Map<String, String> headers = {
      "Content-type": "application/json"
      };

    var request = {
      "phone": bank.phone,
      "password": password,
      "phoneOtp": otp,
      //"referredBy": ""
    }; 

    print(headers);
    print(json.encode(request));

    return http
        .post('$apiUrl/customers', headers: headers, body: json.encode(request))
        .asStream()
        .timeout(Duration(seconds: TIMEOUT_SEC))
        .map((data) {
          print("response " + data.statusCode.toString());
          print("response " + data.body);
          return data.statusCode == 200 ? 
                  PaymentResponse.fromJson(json.decode(data.body)) : throw(data);}
        );
  }

  Stream<CustomerInfoResponse> getAccountInformation() {
     
     Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
      };  

    return http
        .get('$apiUrl/customers?username=${storageManager.mobileNumber}', headers: headers)
        .asStream()
        .timeout(Duration(seconds: TIMEOUT_SEC))
        .map((data) {
          print("response " + data.statusCode.toString());
          print("response " + data.body);
          return data.statusCode == 200? 
                  CustomerInfoResponse.fromJson(json.decode(data.body)) : throw(data);}
        );
  }

  Stream<InitTopUpResponse> initiateTopUp(int customerId, double amount, String uniqueId) {
    
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
      };

    var request = {
      "customerId": customerId,
      "amount": amount,
    };

    print(headers);
    print(json.encode(request));

    return http
        .post('$apiUrl/topups', headers: headers, body: json.encode(request))
        .asStream()
        .timeout(Duration(seconds: TIMEOUT_SEC))
        .map((data) {
          print("response " + data.statusCode.toString());
          print("response " + data.body);
          return data.statusCode == 200 ? 
                  InitTopUpResponse.fromJson(json.decode(data.body)) : throw(data);}
        );
  }

  Stream requestOpt(String mobileNumber) {
    
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
      };

    var request = [
      mobileNumber
    ];

    print(headers);
    print(json.encode(request));

    return http
        .post('$apiUrl/customers/verifications', headers: headers, body: json.encode(request))
        .asStream()
        .timeout(Duration(seconds: TIMEOUT_SEC))
        .map((data) {
          print("response " + data.statusCode.toString());
          return data.statusCode == 204 ? 
                  data : throw(data);}
        );
  }
}