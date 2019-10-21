import 'package:flutter_observer/Observable.dart';

///First change the page of the data using the with field inheritance
///Implement this abstract class to receive notifications sent by Observables.
///In the state initState method you need to call Observable().addObserver(this);
///Call Observable().removeObserver(this) in the state dispose method;
abstract class Observer {
  update(Observable observable,String notifyName, Map map);
}
