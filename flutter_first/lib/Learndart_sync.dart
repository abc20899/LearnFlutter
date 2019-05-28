/**
 * 异步支持
 * 1、返回Future或者Stream对象的函数。 这些函数被称为异步函数
 * 2、async和await关键词支持了异步编程，允许您写出和同步代码很像的异步代码。
 *
 *
 * */

//一、Future
//1、Future.then接受结果 回调  then参数: FutureOr<R> onValue(T value), {Function onError}
void test1() {
  Future.delayed(new Duration(seconds: 2), () {
    return 'hello world';
  }).then((data) {
    print(data);
  });
}

//2、Future.catchError 捕获错误
void test2() {
  Future.delayed(new Duration(seconds: 2), () {
    throw new AssertionError('error');
  }).then((data) {
    //执行成功会走到这里
    print('success');
  }).catchError((e) {
    //执行失败会走到这里
    print(e);
  });
}

////使用 then的参数  onError捕获异常
void test3() {
  Future.delayed(new Duration(seconds: 2), () {
    throw new AssertionError('error');
  }).then((data) {
    print('success');
  }, onError: (e) {
    print(e);
  });
}

//3、Future.whenComplete  异步任务执行成功或失败都需要走的回调函数
void test4() {
  Future.delayed(new Duration(seconds: 2), () {
    throw new AssertionError('error');
  }).then((data) {
    print('success');
  }).catchError((e) {
    print(e);
  }).whenComplete(() {
    print('complete');
  });
}

//4、Future.wait  需要等待多个异步任务都执行结束后才进行一些操作
void test5() {
  Future.wait([
    Future.delayed(new Duration(seconds: 2), () {
      return 'hello';
    }),
    Future.delayed(new Duration(seconds: 4), () {
      return 'world';
    })
  ]).then((results) {
    print(results[0] + results[1]);
  }).catchError((e) {
    print(e);
  });
}

//二、Async/await
//大量的异步任务依赖 避免 回调地狱（Callback Hell）
//登录-->获取用户信息-->保存用户信息
Future<String> login(String userName, String pwd) {}

Future<String> getUserInfo(String id) {}

Future saveUserInfo(String userInfo) {}

//Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用
void test6() {
  login('jack', '1234').then((id) {
    return getUserInfo(id);
  }).then((userInfo) {
    return saveUserInfo(userInfo);
  }).catchError((e) {
    print(e);
  });
}

//使用async/await消除callback hell
task() async {
  try {
    String id = await login('jack', '1234');
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
  } catch (e) {
    print(e);
  }
}
//1)、async 用来表示函数是异步的，定义的函数会返回一个Future对象，可以使用then方法添加回调函数。
//2)、await 后面是一个Future，表示等待该异步任务完成，异步完成后才会往下走；await必须出现在 async 函数内部。

//二、Stream 也是用于接收异步事件数据，和Future 不同的是，它可以接收多个异步操作的结果（成功或失败）
void test7() {
  Stream.fromFutures([
    Future.delayed(new Duration(seconds: 1), () {
      return 'hello 1';
    }),
    Future.delayed(new Duration(seconds: 2), () {
      throw new AssertionError('error');
    }),
    Future.delayed(new Duration(seconds: 3), () {
      return 'hello 3';
    })
  ]).listen((data) {
    print(data);
  }, onError: (e) {
    print(e.message);
  }, onDone: () {});
}

void main() {
//  test1();
//  test2();
//  test3();
//  test4();
//  test5();
  test7();
}
