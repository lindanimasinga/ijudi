
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ijudi/api/ukheshe/model/customer-info-response.dart';
import 'package:ijudi/api/ukheshe/model/error-response.dart';
import 'package:ijudi/api/ukheshe/model/init-topup-response.dart';
import 'package:ijudi/api/ukheshe/model/jwt-response.dart';
import 'package:ijudi/api/ukheshe/model/ukheshe-transaction.dart';
import 'package:ijudi/model/order.dart';
import 'package:ijudi/model/profile.dart';
import 'package:ijudi/services/storage-manager.dart';
import 'package:intl/intl.dart';
import 'model/payment-response.dart';

class UkhesheService {
  
  static const TIMEOUT_SEC = 20;
  final String baseUrl;
  final String apiUrl;
  static Map<String, String> headers = {"Content-Type": "application/json"};
  
  final StorageManager storageManager;

  UkhesheService({this.storageManager, this.baseUrl}) : apiUrl = "$baseUrl/ukheshe-conductor/rest/v1";

  bool get isLoggedIn => storageManager.findUkhesheAccessToken() != null;

  Future<JWTResponse> authenticate(String username, String password) async {
    
    var request = {"identity": username, "password": password};
    print("authenticating");

    var response  =  await  http
        .post('$apiUrl/login', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
   /*     var jsonString = "{\"expires\":\"2020-06-01T16:44:05Z\",\"expiresEpochSecs\":1591029845,\"headerName\":\"Authorization\",\"headerValue\":\"Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIwODEyODE1NzA3IiwidWlkIjozMTg5MzAsImNoIjoic01NczNnVEVSSCIsInJvbGVzIjoiY3VzdG9tZXIiLCJzZXNzIjoiNTE2YWMzYzAtMDRhNC00YTM5LWIzNjAtMTljYjllMTNkNGRhIiwiaXNzIjoiaHR0cDpcL1wvamluaS5ndXJ1IiwiZXhwIjoxNTkxMDI5ODQ1fQ.6CknO0Aewgh-PNbz_uAy7fM_1yNMRXylPiKwsCUZ1mw\",\"roles\":[\"customer\"],\"sessionId\":\"516ac3c0-04a4-4a39-b360-19cb9e13d4da\"}";
        var responseData = http.Response(jsonString, 200);
        var response  =  await  Future.value(responseData); */
    log(response.body);
    if(response.statusCode != 200) throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]).description);
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
    
    if(response.statusCode != 200) throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]).description);
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
      "description": order.description,
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
    print(response.body);    
    return response.statusCode == 200 ? 
                  PaymentResponse.fromJson(json.decode(response.body)) : throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]).description);   
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
      "referredBy": "318930"
    }; 

    print(headers);
    print(json.encode(request));

    var response = await http.post('$apiUrl/customers', 
            headers: headers, 
            body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));

    return response.statusCode == 200 ? 
                  PaymentResponse.fromJson(json.decode(response.body)) : throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]).description);
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
            CustomerInfoResponse.fromJson(json.decode(response.body)) : throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]));
  }


  Future<List<UkhesheTransaction>> getTransactions(int customerId) async {
    
        if(storageManager.hasTokenExpired) {
      refreshToken().then((value) => null);
    }
    
     Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
      };  

    log("fetching all transaction for customer $customerId");
    var event = await http.get('$apiUrl/customers/$customerId/transactions', headers: headers)
        .timeout(Duration(seconds: TIMEOUT_SEC));
    log(event.body);
    if(event.statusCode != 200) throw(UkhesheErrorResponse.fromJson(json.decode(event.body)[0]));  
        
    Iterable list = json.decode(event.body);
    return list.map((f) => UkhesheTransaction.fromJson(f)).toList();        
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
            InitTopUpResponse.fromJson(json.decode(response.body)) : throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]).description);
  }

  Future<InitTopUpResponse> getTopUp(int topupId) async {
    
    if(storageManager.hasTokenExpired) {
      refreshToken();
    }

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": storageManager.findUkhesheAccessToken()
      };

    var response = await http
        .get('$apiUrl/topups/$topupId', headers: headers)
        .timeout(Duration(seconds: TIMEOUT_SEC));
   
    return response.statusCode == 200 ? 
            InitTopUpResponse.fromJson(json.decode(response.body)) : throw(UkhesheErrorResponse.fromJson(json.decode(response.body)[0]).description);
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
    return data.statusCode == 204 ? data : throw(UkhesheErrorResponse.fromJson(json.decode(data.body)[0]).description);
  }

  Future requestPasswordReset(String mobileNumber) async {
        Map<String, String> headers = {
      "Content-type": "application/json"
      };

    var request = {
      "identity" : mobileNumber
    };

    print(headers);
    print(json.encode(request));

    var data = await http
        .post('$apiUrl/customers/password-change-init', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
    return data.statusCode == 200 ? data : throw(UkhesheErrorResponse.fromJson(json.decode(data.body)[0]).description);
  }

  Future resetPassword(Map<String, String> request) async {
    
    Map<String, String> headers = {
      "Content-type": "application/json"
    };

    print(headers);
    print(json.encode(request));

    var data = await http
        .post('$apiUrl/customers/password-change', headers: headers, body: json.encode(request))
        .timeout(Duration(seconds: TIMEOUT_SEC));
    return data.statusCode == 200 ? data : throw(UkhesheErrorResponse.fromJson(json.decode(data.body)[0]).description);
  }
}