
import 'dart:convert';
import 'dart:developer';
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

  bool get isLoggedIn => storageManager.findUkhesheAccessToken() != null;

  Future<JWTResponse> authenticate(String username, String password) async {
    
    var request = {"identity": username, "password": password};
    print("authenticating");

    var response  =  await  http
        .post('$apiUrl/login', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
    log(response.body);
    if(response.statusCode != 200) throw(response.body);
    JWTResponse jwt = JWTResponse.fromJson(json.decode(response.body));
    storageManager.saveUkhesheAccessToken(jwt.headerValue);
    storageManager.saveUkhesheTokenExpiryDate(jwt.expires);
    return jwt;
  }

  Future<JWTResponse> refreshToken() async {

    var token = storageManager.findUkhesheAccessToken();
    var request = {"token": token};
    print("refreshing toke");

    var response  =  await  http
        .post('$apiUrl/login', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
    
    if(response.statusCode != 200) throw(response.body);
    JWTResponse jwt = JWTResponse.fromJson(json.decode(response.body));
    storageManager.saveUkhesheAccessToken(jwt.headerValue);
    storageManager.saveUkhesheTokenExpiryDate(jwt.expires);
    return jwt;
  }

  Future<PaymentResponse> paymentForOrder(Order order) async {

    if(storageManager.hasTokenExpired) {
      refreshToken();
    }

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
    }; 

    var request = {
      "fromAccountId": order.customer.bank.accountId,
      "toAccountId": order.shop.bank.accountId,
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

    var response  =  await http.post('$apiUrl/transfers', 
            headers: headers, 
            body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
        
    return response.statusCode == 200 ? 
                  PaymentResponse.fromJson(json.decode(response.body)) : throw(response);   
  }

  Future registerUkhesheAccount(Bank bank, String otp, String password) async {
    
    if(storageManager.hasTokenExpired) {
      refreshToken();
    }

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

    var response = await http.post('$apiUrl/customers', 
            headers: headers, 
            body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));

    return response.statusCode == 200 ? 
                  PaymentResponse.fromJson(json.decode(response.body)) : throw(response);
  }


  Future<CustomerInfoResponse> getAccountInformation() async {
    
    if(storageManager.hasTokenExpired) {
      refreshToken().then((value) => null);
    }
    
     Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
      };  

    var response = await http
        .get('$apiUrl/customers?username=${storageManager.mobileNumber}', headers: headers)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    log(response.body);
    return response.statusCode == 200? 
            CustomerInfoResponse.fromJson(json.decode(response.body)) : throw(response);
  }


  Future<InitTopUpResponse> initiateTopUp(int customerId, double amount, String uniqueId) async {
    
    if(storageManager.hasTokenExpired) {
      refreshToken();
    }

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

    var response = await http
        .post('$apiUrl/topups', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
   
    return response.statusCode == 200 ? 
            InitTopUpResponse.fromJson(json.decode(response.body)) : throw(response);
  }

  Future requestOpt(String mobileNumber) async {

    Map<String, String> headers = {
      "Content-type": "application/json"
      };

    var request = [
      mobileNumber
    ];

    print(headers);
    print(json.encode(request));

    var data = await http
        .post('$apiUrl/customers/verifications', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
    return data.statusCode == 204 ? data : throw(data);
  }
}