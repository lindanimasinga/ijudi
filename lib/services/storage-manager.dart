
abstract class StorageManager {

  static const ACCESS_TOKEN_IJUDI = "wewhhghtiie";
  static const ACCESS_TOKEN_UKHESHE = "22qqqS#eED";
  static const String MOBILE = "dflwe32w";
  static const String UKHESHE_EXPIRY = "nasdasie2";
  static const String IJUDI_USER_ID = "uiouwfflsdf";
  static const String IJUDI_DEVICE_ID = "lahdkjahskdffdsd";
  static const UKHESHE_PASSWORD = "djalske33bfsdw";

  get mobileNumber;
  set mobileNumber(String value);

  get password;
  set password(String value);

  void saveIjudiAccessToken(String token);

  String findIjudiAccessToken();

  void saveUkhesheAccessToken(String token);

  String findUkhesheAccessToken();

  bool get isLoggedIn;

  String get deviceId;

  set deviceId(String deviceId);

  Stream clear();

  void saveUkhesheTokenExpiryDate(String expires);

  String findUkhesheTokenExpiryDate();

  bool get hasTokenExpired;

  void saveIjudiUserId(String id);

  String getIjudiUserId();

/*
  void save<T extends Entity>(T entity);

  T findById<T extends Entity>(String id);

  List<T> findByName<T extends Entity>(String name);
*/  
  
}