import 'dart:math';

class MockData {
  static final _random = Random();

  static String generateString({int length = 16}) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(
        length, (index) => chars[_random.nextInt(chars.length)]).join();
  }

  static bool generateBoolean() {
    return _random.nextBool();
  }

  static int generateInt({int min = 0, int max = 100}) {
    return min + _random.nextInt(max - min);
  }
}
