import 'dart:math';

class Utils {

  static double generateWaveNumber(int max) {
    var number;
    if(Random().nextBool()) {
      number = Random().nextDouble() >= 0.5 ? 0.8 : 0.4;
      return number;
    }
    number = Random().nextInt(max);
    return number > 0? number.toDouble() : generateWaveNumber(max);
  }
}