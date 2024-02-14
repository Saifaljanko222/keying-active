import 'dart:math';

class charter {
  String generateRandomCharacter() {
    final random = Random();
    int charCode = random.nextInt(26) + 65; // Random uppercase letter (A-Z)
    String character = String.fromCharCode(charCode);
    return character;
  }

  String generateRandomNumberString() {
    final random = Random();
    int number = random.nextInt(100); // Random number between 0 and 99
    return number.toString();
  }

  String generateRandomNumber(int min, int max) {
    final random = Random();
    int number = min + random.nextInt(max - min + 1);
    String name = number.toString();
    return name;
  }
}
