/**
 * pubspec.yaml

    name: flutter_in_action   应用或包名称。
    description: First Flutter application.  应用或包的描述、简介。

    version: 1.0.0+1  应用或包的版本号。

    dependencies:   应用或包依赖的其它包或插件。
    flutter:
    sdk: flutter
    cupertino_icons: ^0.1.2

    dev_dependencies:  开发环境依赖的工具包（而不是flutter应用本身依赖的包）。
    flutter_test:
    sdk: flutter

    flutter:   flutter相关的配置选项。
    uses-material-design: true


    Pub仓库
    是Google官方的Dart Packages仓库，类似于node中的npm仓库，android中的jcenter

    dependencies:
    flutter:
    sdk: flutter

    cupertino_icons: ^0.1.0
    # 新添加的依赖
    english_words: ^3.1.3

    控制台 flutter packages get  获取取依赖包

    引入english_words包。
    import 'package:english_words/english_words.dart';

    使用english_words包来生成随机字符串。



    其它依赖方式
    我们还可以依赖本地包和git仓库。
    如果我们正在本地开发一个包，包名为pkg1，我们可以通过下面方式依赖：

    dependencies:
    pkg1:
    path: ../../code/pkg1

    依赖Git：你也可以依赖存储在Git仓库中的包。如果软件包位于仓库的根目录中，请使用以下语法
    dependencies:
    pkg1:
    git:
    url: git://github.com/xxx/pkg1.git

    上面假定包位于Git存储库的根目录中。如果不是这种情况，可以使用path参数指定相对位置，例如：
    dependencies:
    package1:
    git:
    url: git://github.com/flutter/packages.git
    path: packages/package1
 * */

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsWidget extends StatelessWidget {
  var words = new WordPair.random();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: new Text(words.toString()),
    );
  }
}
