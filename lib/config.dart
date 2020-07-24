abstract class Config {
  static ProdConfig _prodConfig;
  static Config _uatConfig;
  static Config _devConfig;

  String get depositingFnbBankAccountNumber;
  String get depositingNedBankAccountNumber;
  String get ukhesheBaseURL;
  String get iZingaApiUrl;

  static Config get currentConfig => _prodConfig != null
      ? _prodConfig
      : _uatConfig != null ? _uatConfig : _devConfig;

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
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl = "http://localhost/";
}

class UATConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl =
      "http://ec2co-ecsel-1b20jvvw3yfzt-2104564802.af-south-1.elb.amazonaws.com/";
}

class DevConfig extends Config {
  final String depositingFnbBankAccountNumber = "62544036850";
  final String depositingNedBankAccountNumber = "1196782040";
  final String ukhesheBaseURL = "https://ukheshe-sandbox.jini.rocks";
  final String iZingaApiUrl = "http://localhost/";
}
