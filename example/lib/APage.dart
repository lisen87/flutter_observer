import 'package:example/BPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:flutter_observer/Observable.dart';

class APage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return APageState();
  }
}

class APageState extends State<APage> with Observer{

  MaterialColor bc = Colors.pink;
  String notifyText = "接受CPage中的数据";
  @override
  void initState() {
    Observable.instance.addObserver(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bc,
      body: Column(
        children: <Widget>[
          Container(height: 100, child: Center(child: Text("A页面(接受CPage通知后会改变背景色)"))),

          RaisedButton(onPressed: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) {
                  return BPage();
                }));
          }, child: Text("到B页面")),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(notifyText),
          ),

          RaisedButton(
              onPressed: () {
                print("Observable中的数量 = " + Observable.instance.length().toString());
              },
              child: Text("查看Observable中的数量")),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Observable.instance.removeObserver(this);
    super.dispose();
  }
  @override
  update(Observable observable, Map map) {

    if(map != null && map.containsKey("background")){
      bc = map["background"];
    }else if(map != null && map.containsKey("notifyText")){
      notifyText = map["notifyText"];
    }else{
      print("CPage通知所有Observer");
    }

    setState(() {

    });
  }
}
