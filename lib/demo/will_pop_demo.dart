import 'package:flutter/material.dart';

class WillPopScopeRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _WillPopScopeState();

}

class _WillPopScopeState extends State<WillPopScopeRoute> {

  DateTime _lastTimeAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: Text("1秒内连续按两次返回键退出"),
        ),
        onWillPop: () async {
          if (_lastTimeAt == null ||
            DateTime.now().difference(_lastTimeAt) > Duration(seconds: 1)) {
            _lastTimeAt = DateTime.now();
            return false;
          }
          return true;
        });
  }

}