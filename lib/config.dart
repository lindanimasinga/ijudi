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
  final String ukhesheBaseURL = "https://api2.ukheshe.co.za";
  final String iZingaApiUrl = "https://api.izinga.co.za";
  final rangeMap = {'6.5km': 0.043333};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=27104440040&text=VI";
}

class UATConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl =
      "http://izinga-env.eba-a3ratwag.af-south-1.elasticbeanstalk.com";
  final rangeMap = {'16500km': 110.0, '6.5km': 0.043333};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=27104440040&text=VI";
}

class DevConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl = "http://localhost/";
  final rangeMap = {'6.5km': 0.043333, '16500km': 110.0};
  final double centreLatitude = -29.991591;
  final double centrelongitude = 30.885905;
  final String supportPageUrl =
      "https://api.whatsapp.com/send?phone=27812815707";
  final String ukhesheSupportUrl =
      "https://api.whatsapp.com/send?phone=27104440040&text=VI";
}
