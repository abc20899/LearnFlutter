import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int _calculateResult;

  @override
  void initState() {
    super.initState();
//    initPlatformState();
  }

  // 异步调用插件中的方法
  Future<void> initPlatformState() async {
    String platformVersion;
    int calculateResult;
    try {
      platformVersion = await VideoPlayer.platformVersion; //调用插件中的方法
      calculateResult = await VideoPlayer.calculate(10, 10); //调用插件中的方法
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _calculateResult = calculateResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n  cal:$_calculateResult'),
        ),
      ),
    );
  }
}
