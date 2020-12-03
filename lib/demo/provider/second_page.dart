import 'package:flutter/material.dart';
import 'package:flutterapp/demo/provider/my_change_notifier.dart';
import 'package:provider/provider.dart';

/// @Date：2020/11/26
/// @Author：songdongliang
/// Desc：
class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // MyChangeNotifier notifier = Provider.of<MyChangeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("事件产生页"),
      ),
      body: Center(
        child: GestureDetector(
          child: FlatButton(
              onPressed: () {
                context.read<MyChangeNotifier>().incrementCounter();
              },
              child: Text("counter++")
          ),
        ),
      ),
    );
  }

}