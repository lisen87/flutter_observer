# [flutter_observer](https://github.com/lisen87/flutter_observer.git)

android BroadcastReceiver iOS NSNotification

> Supported  Platforms
> * Android
> * iOS

## How to Use

```yaml
# add this line to your dependencies
flutter_observer: ^1.0.6
```

```dart
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
```
```dart
///Accept notification page
class APageState extends State<APage> with Observer{
  @override
    void initState() {
      Observable.instance.addObserver(this);
      super.initState();
    }
 @override
  void dispose() {
    Observable.instance.removeObserver(this);
    super.dispose();
  }
  @override
   update(Observable observable,String notifyName, Map map) {
    ///do your work
      if(map != null && map.containsKey("background")){
        MaterialColor bc = map["background"];
      }else if(map != null && map.containsKey("notifyText")){
        String notifyText = map["notifyText"];
      }else{
        print("通知所有Observer");
      }
      setState(() {
      });
    }
}

///Send notification page
class CPage extends StatefulWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(height: 100, child: Center(child: Text("C页面，负责发送通知"))),
          RaisedButton(
              onPressed: () {
                ///Called where you need to send a notification
                Map map = Map();
                map["background"] = Colors.green;
                ///Observable.instance.notifyObservers(null);
                Observable.instance.notifyObservers([
                  "APageState",
                ], notifyName : "可以通过notifyName判断通知",map: map);
              },
              child: Text("只发送通知到APageState修改背景色")),
        ],
      ),
    );
  }
}

```

Observable property | description
--------|------------
stateNames | List or null
map | {"id":"1"}