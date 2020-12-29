import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/deer/util/toast.dart';

/// @Date：2020/12/29
/// @Author：songdongliang
/// Desc：双击返回退出
class DoubleTapBackExitApp extends StatefulWidget {

  final Widget child;
  // 两次点击返回按钮的时间间隔
  final Duration duration;

  const DoubleTapBackExitApp({
    Key key,
    @required this.child,
    this.duration = const Duration(milliseconds: 2500),
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _DoubleTapBackExitAppState();

}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {

  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: widget.child,
        onWillPop: _isExit
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null || DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show('再次点击退出应用');
      return Future.value(false);
    }
    Toast.cancelToast();
    // 不推荐使用 'dart:io'的exit(0)
    await SystemNavigator.pop();
    return Future.value(true);
  }

}