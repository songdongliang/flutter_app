import 'package:flutter/material.dart';

/// @Date：2021/2/2
/// @Author：songdongliang
/// Desc：
class NotificationTestPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NotificationTestState();

}

class _NotificationTestState extends State<NotificationTestPage> {

  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<_CustomNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += "${notification.msg}    ";
        });
        return true;
      },
        child: Column(
          children: [Text(_msg), _CustomChild()],
        )
    );
  }

}

class _CustomNotification extends Notification {
  final String msg;
  _CustomNotification(this.msg);
}

class _CustomChild extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () => _CustomNotification('Hi,').dispatch(context),
      child: Text("Fire Notification"),
    );
  }

}