
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ijudi/api/ukheshe/model/jwt-response.dart';
import 'package:ijudi/model/order.dart';
import 'model/payment-response.dart';

class UkhesheService {
  
  static String apiBaseUrl = "https://api.ukheshe.co.za/ukheshe-conductor/rest/v1";
  static Map<String, String> headers = {"Content-Type": "application/json"};
  static JWTResponse jwtResponse;

  static Stream<JWTResponse> authenticate(String username, String password) {
    
    var request = {"identity": username, "password": password};
    print("authenticating");
    return http
        .post('$apiBaseUrl/login', headers: headers, body: json.encode(request))
        .asStream()
        .map((data) {
          print("response");
          return data.statusCode != 401? 
                  JWTResponse.fromJson(json.decode(data.body)) : null;}
        )
        .map((response) {
          jwtResponse = response;
          print("response");
          return jwtResponse;
        });
  }

  static Stream<PaymentResponse> paymentForOrder(Order order) {

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": jwtResponse.headerValue
    };

    var request = {
      "fromAccountId": order.busket.customer.bank.account,
      "toAccountId": order.busket.shop.bank.account,
      "type": "MANUAL_APP",
      "amount": order.totalAmount,
      "description": order.busket.shop.name,
      "uniqueId": "1233232132434",
      "externalId": order.id,
      "callbackUrl": "https://music4me.co.za/test",
    };  

    print(request);

    return http
        .post('$apiBaseUrl/transfers', headers: headers, body: json.encode(request))
        .asStream()
        .map((data) {
          print("response " + data.statusCode.toString());
          return data.statusCode != 401? 
                  PaymentResponse.fromJson(json.decode(data.body)) : null;}
        );
  }
}