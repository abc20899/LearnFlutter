import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; //引入 english_words包

class PageFirstWidget extends StatefulWidget {
  @override
  _PageFirstWidgetState createState() => _PageFirstWidgetState();
}

class _PageFirstWidgetState extends State<PageFirstWidget>
    with AutomaticKeepAliveClientMixin {
  final _suggestions = <WordPair>[]; //声明一个list

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Widget _buildList() {
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

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  @override
  bool get wantKeepAlive => true;
}
