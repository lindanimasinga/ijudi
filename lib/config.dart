abstract class Config {
  static ProdConfig _prodConfig;
  static Config _uatConfig;
  static Config _devConfig;

  String get depositingFnbBankAccountNumber;
  String get depositingNedBankAccountNumber;
  String get ukhesheBaseURL;
  String get iZingaApiUrl;
  Map<String, double> get rangeMap;

  static Config get currentConfig => _prodConfig != null
      ? _prodConfig
      : _uatConfig != null ? _uatConfig : _devConfig;

  static Config getProConfig() {
    if (_prodConfig == null) {
      _prodConfig = ProdConfig();
    }
    _uatConfig = null;
    _devConfig = null;
    return _prodConfig;
  }

  static Config getUATConfig() {
    if (_uatConfig == null) {
      _uatConfig = UATConfig();
    }
    _prodConfig = null;
    _devConfig = null;
    return _uatConfig;
  }

  static Config getDEVConfig() {
    if (_devConfig == null) {
      _devConfig = DevConfig();
    }
    _uatConfig = null;
    _prodConfig = null;
    return _devConfig;
  }
}

class ProdConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://api2.ukheshe.co.za";
  final String iZingaApiUrl = "https://api.izinga.co.za";
  final rangeMap = {'6.5km': 0.043333};
}

class UATConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl =
      "http://izinga-env.eba-a3ratwag.af-south-1.elasticbeanstalk.com";
  final rangeMap = {'16500km': 110.0, '6.5km': 0.043333};
}

class DevConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl = "http://localhost/";
  final rangeMap = {'6.5km': 0.043333, '16500km': 110.0};
}
