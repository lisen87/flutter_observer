import 'package:example/CPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';

class BPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BPageState();
  }

}
class BPageState extends State<BPage> with Observer{

  String notifyText = "接受CPage中的通知";
  @override
  void initState() {
    Observable.instance.addObserver(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(height: 100, child: Center(child: Text("B页面"))),

        ElevatedButton(onPressed: () {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) {
            return CPage();
          }));
        }, child: Text("到C页面")),

        Text(notifyText),

      ],),
    );
  }

  @override
  void dispose() {
    Observable.instance.removeObserver(this);
    super.dispose();
  }

  @override
  update(Observable observable,String? notifyName, Map? map) {
    notifyText = "I received notifycation";
    print("notifyName=>$notifyName");
    if(map == null){
      print("CPage通知所有Observer");
    }
    setState(() {

    });
  }
}