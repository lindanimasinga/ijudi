import 'package:ijudi/model/supported-location.dart';

abstract class Config {
  static ProdConfig _prodConfig;
  static Config _uatConfig;
  static Config _devConfig;
  static Config currentConfig;
  double centreLatitude;
  double centrelongitude;
  String supportPageUrl;
  String ukhesheSupportUrl;

  String get depositingFnbBankAccountNumber;
  String get depositingNedBankAccountNumber;
  String get ukhesheBaseURL;
  String get iZingaApiUrl;
  List<SupportedLocation> get locations;

  Map<String, double> get rangeMap;

  static Config getProConfig() {
    if (_prodConfig == null) {
      _prodConfig = ProdConfig();
    }
    return _prodConfig;
  }

  static Config getUATConfig() {
    if (_uatConfig == null) {
      _uatConfig = UATConfig();
    }
    return _uatConfig;
  }

  static Config getDEVConfig() {
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
  final rangeMap = {'10km': 0.066666};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=270684835566&text=Hello";
  final List<SupportedLocation> locations = [
    SupportedLocation("KwaMashu", -29.7380334, 30.9553919),
    SupportedLocation("Durban North", -29.7789353, 31.0113643),
    SupportedLocation("uMhlanga", -29.7345642, 31.0472124),
    SupportedLocation("Newlands East", -29.7713802, 30.9715548),
    SupportedLocation("Avoca", -29.7690195, 31.0063363),
    SupportedLocation("Red Hill", -29.7645907, 31.0201387),
    SupportedLocation("Ntuzuma", -29.7412106, 30.9284555),
    SupportedLocation("Phoenix DBN", -29.7010308, 30.9727855)
  ];
}

class UATConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://api.ukheshe.co.za";
  final String iZingaApiUrl = "https://api-uat.izinga.co.za";
  final rangeMap = {'16500km': 110.0, '10km': 0.066666};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=270684835566&text=Hello";
  final List<SupportedLocation> locations = [
    SupportedLocation("KwaMashu", -29.7380334, 30.9553919),
    SupportedLocation("Durban North", -29.7789353, 31.0113643),
    SupportedLocation("uMhlanga", -29.7345642, 31.0472124),
    SupportedLocation("Newlands East", -29.7713802, 30.9715548),
    SupportedLocation("Avoca", -29.7690195, 31.0063363),
    SupportedLocation("Red Hill", -29.7645907, 31.0201387),
    SupportedLocation("Ntuzuma", -29.7412106, 30.9284555),
    SupportedLocation("Phoenix DBN", -29.7010308, 30.9727855)
  ];
}

class DevConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl = "http://localhost/";
  final rangeMap = {'10km': 0.066666, '16500km': 110.0};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=270684835566&text=Hello";
  final List<SupportedLocation> locations = [
    SupportedLocation("KwaMashu", -29.7380334, 30.9553919),
    SupportedLocation("Durban North", -29.7789353, 31.0113643),
    SupportedLocation("uMhlanga", -29.7345642, 31.0472124),
    SupportedLocation("Newlands East", -29.7713802, 30.9715548),
    SupportedLocation("Avoca", -29.7690195, 31.0063363),
    SupportedLocation("Red Hill", -29.7645907, 31.0201387),
    SupportedLocation("Ntuzuma", -29.7412106, 30.9284555),
    SupportedLocation("Phoenix DBN", -29.7010308, 30.9727855)
  ];
}
