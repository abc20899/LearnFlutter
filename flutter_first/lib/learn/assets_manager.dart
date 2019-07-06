/**
    flutter:
    assets:
    - assets/my_icon.png
    - assets/background.png
 * */

import 'package:flutter/services.dart' show rootBundle;

//加载文本assets
Future<String> loadAssest() async {
  return await rootBundle.loadString('assets/config.json');
}

//加载图片
//Widget build(BuildContext context) {
//  return Image.asset('graphics/background.png');
//}

//依赖包中的资源图片  必须给AssetImage提供package参数。
//new AssetImage('icons/heart.png', package: 'my_icons')
//new Image.asset('icons/heart.png', package: 'my_icons')


void main() {
}