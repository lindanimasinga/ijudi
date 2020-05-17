
abstract class StorageManager {

  static const ACCESS_TOKEN_IJUDI = "wewhhghtiie";
  static const ACCESS_TOKEN_UKHESHE = "22qqqS#eED";
  static const String MOBILE = "dflwe32w";

  get mobileNumber;
  set mobileNumber(String value);

  void saveIjudiAccessToken(String token);

  String findIjudiAccessToken();

  void saveUkhesheAccessToken(String token);

  String findUkhesheAccessToken();

  bool isLoggedIn();

  void clear();

/*
  void save<T extends Entity>(T entity);

  T findById<T extends Entity>(String id);

  List<T> findByName<T extends Entity>(String name);
*/  
  
}