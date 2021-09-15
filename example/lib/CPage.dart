import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_observer/Observable.dart';

class CPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CPageState();
  }
}

class CPageState extends State<CPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(height: 100, child: Center(child: Text("C页面，负责发送通知"))),
          ElevatedButton(
              onPressed: () {
                Map map = Map();
                map["background"] = Colors.green;
                Observable().notifyObservers([
                  "APageState",
                ], map: map);
              },
              child: Text("只发送通知到APageState修改背景色")),
          ElevatedButton(
              onPressed: () {
                Map map = Map();
                map["notifyText"] = "我是CPage发来的通知";
                Observable().notifyObservers([
                  "APageState",
                ], map: map);
              },
              child: Text("只发送通知到APageState修改文本显示")),
          ElevatedButton(
              onPressed: () {
                Observable.instance.notifyObservers([
                  "BPageState",
                ],notifyName : "可以通过notifyName判断通知",map: Map());
              },
              child: Text("只发送通知到BPageState")),
          ElevatedButton(
              onPressed: () {
                Observable.instance.notifyObservers([]);
              },
              child: Text("发送通知到任何Observer")),

          ElevatedButton(
              onPressed: () {
                print("Observable中的数量 = " + Observable.instance.length().toString());
              },
              child: Text("查看Observable中的数量")),
        ],
      ),
    );
  }
}
