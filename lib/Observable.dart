import 'package:flutter_observer/Observer.dart';

///单例 被观察者

class Observable {
  factory Observable() {
    return _getInstance();
  }

  static Observable _instance = Observable._();

  static Observable get instance => _instance;

  static Observable _getInstance() {
    return _instance;
  }

  List<Observer> observers;

  Observable._() {
    observers = List();
  }

  int length() {
    return observers.length;
  }

  ///添加观察者
  addObserver(Observer observer) {
    if (!_checkContains(observer)) {
      observers.add(observer);
    }
  }

  ///在页面不使用的时候移除观察者
  removeObserver(Observer observer) {
    observers.remove(observer);
  }

  ///发送通知的页面中使用
  /// stateNames 要更新的state 名称
  /// map 通知数据，可以为null
  notifyObservers(List<String> stateNames, {Map map}) {
    if (stateNames == null || stateNames.length == 0) {
      for (int i = observers.length - 1; i >= 0; i--) {
        observers[i].updata(this, map);
      }
    } else {
      stateNames.forEach((stateName) {
        for (int i = observers.length - 1; i >= 0; i--) {
          if (stateName == observers[i].toString().split("#")[0].toString()) {
            observers[i].updata(this, map);
          }
        }
      });
    }
  }

  ///检查是否添加过，防止在dispose方法中未调用removeObserver，出现错误
  bool _checkContains(Observer observer) {
    List list = observer.toString().split("#");
    for (int i = 0; i < observers.length; i++) {
      if (observers[i].toString().contains(list[0].toString())) {
        observers.removeAt(i);
        observers.insert(i, observer);
        return true;
      }
    }
    return false;
  }
}
