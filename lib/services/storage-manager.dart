
abstract class StorageManager {

  static const ACCESS_TOKEN_IJUDI = "wewhhghtiie";
  static const ACCESS_TOKEN_UKHESHE = "22qqqS#eED";
  static const String MOBILE = "dflwe32w";

  static String UKHESHE_EXPIRY;

  get mobileNumber;
  set mobileNumber(String value);

  void saveIjudiAccessToken(String token);

  String findIjudiAccessToken();

  void saveUkhesheAccessToken(String token);

  String findUkhesheAccessToken();

  bool get isLoggedIn;

  void clear();

  void saveUkhesheTokenExpiryDate(String expires);

  String findUkhesheTokenExpiryDate();

  bool get hasTokenExpired;

/*
  void save<T extends Entity>(T entity);

  T findById<T extends Entity>(String id);

  List<T> findByName<T extends Entity>(String name);
*/  
  
}