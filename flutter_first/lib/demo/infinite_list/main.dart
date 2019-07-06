import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; //引入 english_words包

//main函数使用了(=>)符号, 这是Dart中单行函数或方法的简写。
void main() => runApp(new MyApp2());

//该应用程序继承了 StatelessWidget，这将会使应用本身也成为一个widget
//Scaffold 是 Material library 中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
//widget的主要工作是提供一个build()方法来描述如何根据其他较低级别的widget来显示自己。
//本例中body的widget树中包含了一个Center widget, Center widget又包含一个 Text 子widget。
//Center widget可以将其子widget树对其到屏幕中心。

//Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
//Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
//1、一个 StatefulWidget类。
//2、一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(primaryColor: Color.fromARGB(255, 255, 78, 77) //argb 颜色
          ),
      home: new RandomWords(),
    );
  }
}

//创建有状态的widget
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; //声明一个list
  final _saved = new Set<WordPair>(); //不允许重复
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    //在Dart语言中使用下划线前缀标识符，会强制其变成私有的。
//    final worldPair = new WordPair.random();
//    return new Text(worldPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        //某些widget属性需要单个widget（child），而其它一些属性，如action，需要一组widgets(children），用方括号[]表示。
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //ListView类提供了一个builder属性，itemBuilder 值是一个匿名回调函数， 接受两个参数- BuildContext和行迭代器i。迭代器从0开始，
  // 每调用一次该函数，i就会自增1，对于每个建议的单词对都会执行一次。
  //typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          //在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider(); //奇数

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    //判断是否添加到收藏
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        //在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    //新页面的内容在MaterialPageRoute的builder属性中构建，builder是一个匿名函数。
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      //builder返回一个Scaffold，其中包含名为“Saved Suggestions”的新路由的应用栏。
      // 新路由的body由包含ListTiles行的ListView组成; 每行之间通过一个分隔线分隔。
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}
