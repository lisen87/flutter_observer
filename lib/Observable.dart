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

  List<Observer> observers;

  Observable._() {
    observers = List();
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

  ///Remove viewers when the page is not in use
  removeObserver(Observer observer) {
    observers.remove(observer);
  }

  ///Used in the page that sent the notification
  /// stateNames state name to update
  /// Map notification data, can be null
  notifyObservers(List<String> stateNames, {Map map}) {
    if (stateNames == null || stateNames.length == 0) {
      for (int i = observers.length - 1; i >= 0; i--) {
        observers[i].update(this, map);
      }
    } else {
      stateNames.forEach((stateName) {
        for (int i = observers.length - 1; i >= 0; i--) {
          if (stateName == observers[i].toString().split("#")[0].toString()) {
            observers[i].update(this, map);
          }
        }
      });
    }
  }

  ///Check if it has been added to prevent the removal of remove Observer in the dispose method, an error occurs
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
