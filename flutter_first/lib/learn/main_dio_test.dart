import 'package:dio/dio.dart';

void getBaidu() async {
  try {
    var response = await Dio().get('http://www.baidu.com');
    print(response);
  } catch (e) {
    print(e);
  }
}

void main() {
  getBaidu();
}

//利用curl命令来验证 server是否支持断点续传
/**
    curl -H "Range: bytes=0-10" http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg -v
    # 请求头
    > GET /HBuilder.9.0.2.macosx_64.dmg HTTP/1.1
    > Host: download.dcloud.net.cn
    > User-Agent: curl/7.54.0
    > Accept:
    > Range: bytes=0-10
    #响应头
    < HTTP/1.1 206 Partial Content
    < Content-Type: application/octet-stream
    < Content-Length: 11
    < Connection: keep-alive
    < Date: Thu, 21 Feb 2019 06:25:15 GMT
    < Content-Range: bytes 0-10/233295878
 * */
//如果服务器支持分块传输，则响应状态码为206，表示“部分内容”，并且同时响应头中包含”Content-Range“字段，如果不支持则不会包含。