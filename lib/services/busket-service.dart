import 'package:ijudi/model/busket.dart';
import 'package:ijudi/model/shop.dart';
import 'package:ijudi/model/userProfile.dart';

class BusketService {

  Busket createNew(UserProfile user, Shop shop) {
    return Busket(user, shop);
  }
  
}