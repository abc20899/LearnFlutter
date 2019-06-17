import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_first/net/code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'http_error_event.dart';
import 'index.dart';

class HandleEvent extends StatefulWidget {
  final Widget child;

  HandleEvent({Key key, this.child}) : super(key: key);

  @override
  _HandleEventState createState() => _HandleEventState();
}

class _HandleEventState extends State<HandleEvent> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  String network_error_401 = "[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]";
  String network_error_403 = "403权限错误";
  String network_error_404 = "404错误";
  String network_error_timeout = "请求超时";
  String network_error_unknown = "其他异常";
  String network_error = "网络错误";

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: network_error);
        break;
      case 401:
        Fluttertoast.showToast(msg: network_error_401);
        break;
      case 403:
        Fluttertoast.showToast(msg: network_error_403);
        break;
      case 404:
        Fluttertoast.showToast(msg: network_error_404);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        Fluttertoast.showToast(msg: network_error_timeout);
        break;
      default:
        Fluttertoast.showToast(msg: network_error_unknown + " " + message);
        break;
    }
  }
}
