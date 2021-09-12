import 'package:ijudi/model/supported-location.dart';

abstract class Config {
  static ProdConfig? _prodConfig;
  static Config? _uatConfig;
  static Config? _devConfig;
  static Config? currentConfig;
  double? centreLatitude;
  double? centrelongitude;
  late String supportPageUrl;
  late String ukhesheSupportUrl;

  String get depositingFnbBankAccountNumber;
  String get depositingNedBankAccountNumber;
  String get ukhesheBaseURL;
  String get iZingaApiUrl;
  String get paymentUrl;

  Map<String, double> get rangeMap;

  static Config? getProConfig() {
    if (_prodConfig == null) {
      _prodConfig = ProdConfig();
    }
    return _prodConfig;
  }

  static Config? getUATConfig() {
    if (_uatConfig == null) {
      _uatConfig = UATConfig();
    }
    return _uatConfig;
  }

  static Config? getDEVConfig() {
    if (_devConfig == null) {
      _devConfig = DevConfig();
    }
    return _devConfig;
  }
}

class ProdConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://api.ukheshe.co.za";
  final String iZingaApiUrl = "https://api.izinga.co.za";
  final rangeMap = {'15km': 0.09999};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=270684835566&text=Hello";

  final String paymentUrl = "https://pay-izinga.web.app";
}

class UATConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://api.ukheshe.co.za";
  final String iZingaApiUrl = "https://api-uat.izinga.co.za";
  final rangeMap = {'16500km': 110.0, '15km': 0.09999};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=270684835566&text=Hello";

  final String paymentUrl = "https://pay-izinga-uat.web.app";
}

class DevConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl = "http://192.168.1.19/";
  final rangeMap = {'15km': 0.066666, '16500km': 110.0};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=270684835566&text=Hello";

  final String paymentUrl = "https://pay-izinga-uat.web.app";
}
