import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ListLoadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListLoadPageState();
}

class _ListLoadPageState extends State<ListLoadPage>
    with SingleTickerProviderStateMixin {

  List<WordPair> data = <WordPair>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onRefresh(RefreshController controller, List<WordPair> data) async {
    await Future.delayed(Duration(milliseconds: 1000));
    data.clear();
    await data.addAll(generateWordPairs().take(10));
    setState(() {});
    controller.refreshCompleted();
  }

  void _onLoading(RefreshController controller, List<WordPair> data) async {
    await Future.delayed(Duration(milliseconds: 2000));
    await data.addAll(generateWordPairs().take(10));
    setState(() {});
    controller.loadComplete();
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => _buildRow(data[i]),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.grey,
        );
      },
      itemCount: data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    data.addAll(generateWordPairs().take(10));

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      child: buildList(),
      controller: _refreshController,
      onRefresh: () {
        _onRefresh(_refreshController, data);
      },
      onLoading: () {
        _onLoading(_refreshController, data);
      },
    );
  }
}
