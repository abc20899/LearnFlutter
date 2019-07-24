import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import "package:pointycastle/export.dart";

import 'aes_helper.dart';
import 'convert_helper.dart';
import 'hihihi.dart';

void main() {
  String cdata =
      "VkyH8nZ6bCaRpM64JrjLLFZiXGummrjqwvO8CBEkqVGp0pzBnsbBP2LyzZ35LQ1VRRJodo1R5Psotj7iN5vi7vW+HZXCHmCReBfQUiV9MZ2iWuVIMpWenpF1Q38kk55BozsUasRIhY94lVNzrcyHC8RWcPJq7Qsj5NarGR589DBXbPFBBKvJboCsMYZV4+DnqKsej/b9ZLkt4+ElL9rgw0D2euWz2EZhFH/N0e528MuBf6P/ZlOuzHzhTe+6yfwcJIkdUNqG/BDCeh84jG/3TBaFW/AZrb4HH2brkTPM1uudzR2l6tvrNcTN9Ra8mRd+kqu/Q/b7KcI51Yx2lxhVlvYFEFRsYUn6izrrz/apJO1Prfd2ye1FslefoMDLcSoHucuKTIzWHCQSTbwfoVrSJV/pMekuW27qwYYavo/NTOCcEpT/qP/BYYeNaLzDu7RkKZXnF29zmaH3dONmQ55jX++kYOe3h5vUCCdQxa7XU56EbmfmUHXKMmmmYMzxTZKmfGX892h82oy0SU//4E2N+oCEZs4FR1PKMQ7E3UXK7CGoE3xhed9KNaqJtIQO0eBRrcp0N70xNDblFzb4ywmj03LH8ihhQeq9tSx/4dWkLzQw9XZ/6PpkKcHSpydD4jqgdczbQKE/Ueu/2F+WtJaHSsmrkisuQzIazT7Ja/cenOokOdiAXj+dA6yvBP9ybS++bNfZK2eGvi+vx7AQrrAGLQgn5/BR9OZUJ2JhIfF24viL6qkwAzB6WgLzHgRA8yVEbXi/bDipiFZkI9sZ9jELmSz5kDK5Y6QSfYA42HwRK6tEni7sY1rIRrJ3xBFKzzpqNE93Xxo7T7naxmzSyk66tg==";
  final cdecrypted = decrypt(cdata, '8q(yd98^&76d7typ', "DJ@#dd'a'asl;dfk");
  print('clip  $cdecrypted');

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

  const String A = 'film'; //player
  const String B = 'string'; //video
  final asa = getAAA(A, B);
  print('asa $asa');

  String sSrc =
      "2lb4VbOGzLSfawQNjtBrLTtyyKMZ8wf65n/MBjUDUVIACYUrykeQ5jA2NxGhjdtQaDUWsh1mLpCqzLlinFyTjpm7haUDwuLaEQsTAQ3rViX+C3Is0CxI6t2l67kN56Z8m/98bHH9DGNRH2TahzTC8o2TWbP9HAiCHIEboh4T0claUdc45y/zwA71MdBSIeG8U2daJ+rOu6eap9iUqL7gPZx7dDsfzqOpMTLYIFIikw67BWvfOjoSu4rhNjOylsCnEXOOVl3FIPLEv5Wda9Dux3kPmrn37mc1yphS3aJJpN1GHuw6GMBtlPQHw3i1zEX2+s/k+cyd0UqXyuN7R88fviBvelDeD3mFAoqFxl+EyXqUY8NeaQVl7ObxR3U8P9pDF4x5MULTVnZXdcX4ugfkTpgwGm9M9K4FzWULLtNBwQq6mN/WKGSTsZOPPtIxcwvWs1SwobNHHDe9dAA3yhY4CdKhnwQVamc8FsRkfwTjWgDuhDwpfWohS8vmaeRvBQ6DvnkEvmGqUH5CkyhhWurMi3sONV2G6MEcd35n4YO9wzpK8KLF+HJKoa2fOPav54CistZXfDbZ5kBAIao10z+eiV6TiWt6UgrICgSS4f8XLOswZU9OwXiWJ9xLtcsnInjDbVdFxRImB2XL25TcQul9o/gV71VCmidcc38Y/fb7Mc8oibDWUAn7bd2xWQVP2UKKEcw76+2NzSrRogs0NVTj2zlNw3g17r6Xx04rApSHwjnB4x+AfNiYQ0VWTSCAlN/wI2zCvcJcWzQmN1sqMoCKrUHnchTUSYJfIzMJKDtkkzUhSLDqIwMzeL5SF0ZWN/B3TwKakUEEVTunIimJe1S+XTvsAK1HGDDwNN8PHKGkttcJIOgCDQFOvhXdkjyS+po1Nhcsk6/JrhdFByryftSgbVIeBLZfZTJ5tqLDOfYam8fwJZjJNq3ck6SFB+Qm4BnbCLJify5YYX8wWFVsOVwFtDzYp/zGThsgTnpvrTolajyKZE3EHae1LZma/rI+xbc3mJvT9mcfIu67LXzGRGhYsd+Jbu/pEUpfi6yAv57/ldm5+8zowLK5WG2fyWwV0Hc8w05W6quJ+ywVW6sbO2AP6NksSc0ahEHaQwMrHhnWLTk5R2KrGulMuvSyepIpHgXTYWSSSWG0O0rBA+EF9zWK7K2s12Qs1b9ATgyNbmLWYLUM4weyRymnoSA/0D/X+tbQvCS7uAap/lZlm8JIPWjKN6kCYa3t7H4s5JbAzrGkiCgSj8DmLH5KSww7wotOsXeFh4xV+Fvsl52Ewj+E3x5egqm7gfm88B+IfofVHlyIhyK04WHZKeIhEkeSAy4YIbfrMBx7W10TQlQHbVK5Crxae8oDqlpENFDCuDUr5kwEQl+s+PgLsDT7GXBjbQ2zv27LGEsB7GcFqh6sZlJFYzutsHVs9dXETv6GsoGd/osbjqKW42UKbWJHuqiQFxV8546l";
  sSrc = sSrc.replaceAll("\n", "");
  String plantt = decrypt(sSrc, "AUsC/WReaTJfzOaU", null);
  print('plantt $plantt');

  int v = -10;
  int c = 2;
  int ss = (v << c) | (v >> (32 - c));
  print(ss); //40
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

String getAAA(String a, String b) {
  String key = getMd5(a + b);
  String nonce = b + b;
  final keyBytes = createUint8ListFromString(key);
  final nonceBytes = nonce.length > 8
      ? createUint8ListFromString(nonce.substring(0, 8))
      : createUint8ListFromString(nonce);
  String c = a;
  while (c.length < 16) {
    var ret = new Uint8List(c.length);
    Hihihi cipher = new Hihihi(keyBytes, nonceBytes, 0);
//    print(cipher.input);
    cipher.encrypt(ret, createUint8ListFromString(c), c.length);
//    print(ret);
    c = base64.encode(ret);
  }
  return c;
}

String decrypt(String sSrc, String sKey, String ivStr) {
  IV civ = null;
  final cKey = Key.fromUtf8(sKey);
  if (ivStr != null) {
    civ = IV.fromUtf8(ivStr);
  } else {
    List<int> vv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    final iv = Uint8List.fromList(vv);
    civ = IV(iv);
  }
  final cencrypter = Encrypter(AES(cKey, mode: AESMode.cbc, padding: 'PKCS7'));
  final cdecrypted = cencrypter.decrypt64(sSrc, iv: civ);
  return cdecrypted;
}
