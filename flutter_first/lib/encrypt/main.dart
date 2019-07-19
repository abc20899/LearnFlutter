import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

import 'convert_helper.dart';

void main() {
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

//  print(decrypted);
//  print(encrypted.bytes);
//  print(encrypted.base16);
//  print(encrypted.base64);

//  Encrypter(AES(key, iv, mode: AESMode.ecb, padding: null))

  String cdata =
      "VkyH8nZ6bCaRpM64JrjLLFZiXGummrjqwvO8CBEkqVGp0pzBnsbBP2LyzZ35LQ1VRRJodo1R5Psotj7iN5vi7vW+HZXCHmCReBfQUiV9MZ2iWuVIMpWenpF1Q38kk55BozsUasRIhY94lVNzrcyHC8RWcPJq7Qsj5NarGR589DBXbPFBBKvJboCsMYZV4+DnqKsej/b9ZLkt4+ElL9rgw0D2euWz2EZhFH/N0e528MuBf6P/ZlOuzHzhTe+6yfwcJIkdUNqG/BDCeh84jG/3TBaFW/AZrb4HH2brkTPM1uudzR2l6tvrNcTN9Ra8mRd+kqu/Q/b7KcI51Yx2lxhVlvYFEFRsYUn6izrrz/apJO1Prfd2ye1FslefoMDLcSoHucuKTIzWHCQSTbwfoVrSJV/pMekuW27qwYYavo/NTOCcEpT/qP/BYYeNaLzDu7RkKZXnF29zmaH3dONmQ55jX++kYOe3h5vUCCdQxa7XU56EbmfmUHXKMmmmYMzxTZKmfGX892h82oy0SU//4E2N+oCEZs4FR1PKMQ7E3UXK7CGoE3xhed9KNaqJtIQO0eBRrcp0N70xNDblFzb4ywmj03LH8ihhQeq9tSx/4dWkLzQw9XZ/6PpkKcHSpydD4jqgdczbQKE/Ueu/2F+WtJaHSsmrkisuQzIazT7Ja/cenOokOdiAXj+dA6yvBP9ybS++bNfZK2eGvi+vx7AQrrAGLQgn5/BR9OZUJ2JhIfF24viL6qkwAzB6WgLzHgRA8yVEbXi/bDipiFZkI9sZ9jELmSz5kDK5Y6QSfYA42HwRK6tEni7sY1rIRrJ3xBFKzzpqNE93Xxo7T7naxmzSyk66tg==";
  final cKey = Key.fromUtf8('8q(yd98^&76d7typ');
  final civ = IV.fromUtf8("DJ@#dd'a'asl;dfk");
  final cencrypter = Encrypter(AES(cKey, mode: AESMode.cbc, padding: 'PKCS7'));
  final cdecrypted = cencrypter.decrypt64(cdata, iv: civ);
  print(cdecrypted);

  String playU = 'https://play.moviefanclub.cn/parse/play/url';
  Uri uri = Uri.parse(playU);
  String stream = uri.path;
  String rand = randomStr(10);
  String timestamp =
      (DateTime.now().millisecondsSinceEpoch / 1000).round().toString();
  print(stream);
  print(rand);
  print(timestamp);

  final rand1 = "RGj04Ibawe";
  final timestamp1 = "1563502540";

  final ret = getSSS();
  final nonce = getNene(timestamp1, rand1);
  print("nonce-- " + nonce);
  final sign = scsc(stream, timestamp1, '1.1.7', nonce);
  print(sign);
}

String getSSS() {
  const String A = 'film'; //player
  const String B = 'string'; //video
  String key = getMd5(A + B);
  key = key.length > 16 ? key.substring(0, 16) : key;
  String ret = asEncrypt(A + B, key);
  return ret;
}

String getMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

String asEncrypt(String sSrc, String sKey) {
  String iv = '0000000000000000';
  final cKey = Key.fromUtf8(sKey);
  final civ = IV.fromUtf8(iv);
  final cencrypter = Encrypter(AES(cKey, mode: AESMode.cbc));
  final encrypted = cencrypter.encrypt(sSrc, iv: civ);
  return formatBytesAsHexString(encrypted.bytes);
}

String scsc(String uri, String timestamp, String version, String nonce) {
  String key = getSSS();
  String sign =
      genHmacSha1((uri + "|" + timestamp + "|" + version + "|" + nonce), key);
  return sign;
}

String getNene(String timestamp, String rand) {
  String key = getSSS();
  String nonce = genHmacSha1((timestamp + "|" + rand), key);
  return nonce;
}

String genHmacSha1(String data, String keyStr) {
  final key = utf8.encode(keyStr);
  final dataBytes = utf8.encode(data);
  final hmacSha1 = new Hmac(sha1, key);
  final digest = hmacSha1.convert(dataBytes);
  String hashtext = digest.toString();
  while (hashtext.length < 40) {
    hashtext = "0" + hashtext;
  }
  return hashtext;
}

String randomStr(int length) {
  String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  Random random = Random();
  String rand = '';
  for (int i = 0; i < length; i++) {
    int num = random.nextInt(str.length);
    rand += str[num];
  }
  return rand;
}
