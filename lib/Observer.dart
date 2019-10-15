import 'package:flutter_observer/Observable.dart';

///先要改变数据的页面State使用 with 字段继承
///实现此抽象类 可以接收到 Observable 发送的通知,
///在state initState 方法中需调用 Observable().addObserver(this);
///在在state dispose方法中调用 Observable().removeObserver(this);
///观察者
abstract class Observer {
  updata(Observable observable, Map map);
}
