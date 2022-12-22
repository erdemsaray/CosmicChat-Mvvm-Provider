import 'package:encrypt/encrypt.dart';

class EncryptionService {
  String encryptText(String plainText, String specialKey, bool status) {
    specialKey = padString(specialKey);

    if (status) {
      final key = Key.fromUtf8(specialKey);
      final iv = IV.fromLength(16);

      final encrypter = Encrypter(AES(key));

      final encrypted = encrypter.encrypt(plainText, iv: iv);
      plainText = encrypted.base64;

      //final decrypted = encrypter.decrypt(encrypted, iv: iv);
    }

    // R4PxiU3h8Yo

    return plainText;
  }

  String decryptText(String plainText, String specialKey, bool status) {
    specialKey = padString(specialKey);

    if (status) {
      final key = Key.fromUtf8(specialKey);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));

      try {
        final decrypted = encrypter.decrypt64(plainText, iv: iv);
        plainText = decrypted;
      } catch (e) {
        plainText = '******************';
      }

      //final encrypted = encrypter.encrypt(plainText, iv: iv);

      //plainText = encrypted.base64;

    }

    // R4PxiU3h8Yo

    return plainText;
  }

  String padString(String value) {
    while (value.length < 32) {
      value = "0$value";
    }
    return value;
  }
}
