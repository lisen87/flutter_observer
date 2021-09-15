import 'package:flutter_observer/Observer.dart';

///Single case

class Observable {
  factory Observable() {
    return _getInstance();
  }

  static Observable _instance = Observable._();

  static Observable get instance => _instance;

  static Observable _getInstance() {
    return _instance;
  }

  late List<Observer> observers;

  Observable._() {
    observers = [];
  }

  int length() {
    return observers.length;
  }

  ///Add observer
  addObserver(Observer observer) {
    if (!_checkContains(observer)) {
      observers.add(observer);
    }
  }

  ///重复添加
  ///add Repeatedly
  addRepeatedlyObserver(Observer observer) {
    observers.add(observer);
  }

  ///Remove viewers when the page is not in use
  removeObserver(Observer observer) {
    observers.remove(observer);
  }

  ///Used in the page that sent the notification
  /// stateNames state name to update
  /// Map notification data, can be null
  notifyObservers(List<String> stateNames, {String? notifyName,Map? map}) {
    if (stateNames.length == 0) {
      for (int i = observers.length - 1; i >= 0; i--) {
        observers[i].update(this, notifyName,map);
      }
    } else {
      stateNames.forEach((stateName) {
        for (int i = observers.length - 1; i >= 0; i--) {
          if (stateName == observers[i].runtimeType.toString()) {
            observers[i].update(this,notifyName, map);
          }
        }
      });
    }
  }

  ///Check if it has been added to prevent the removal of remove Observer in the dispose method, an error occurs
  bool _checkContains(Observer observer) {
    for (int i = 0; i < observers.length; i++) {
      if (observers[i].runtimeType.toString() == (observer.runtimeType.toString())) {
        observers.removeAt(i);
        observers.insert(i, observer);
        return true;
      }
    }
    return false;
  }
}
