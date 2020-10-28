import 'package:flutter/material.dart';

class ListenersDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ListenerState();

}

class _ListenerState extends State<ListenersDemo> {

  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Listener(
        child: Container(
          alignment: Alignment.center,
          width: 300.0,
          height: 150.0,
          child: Text(_event?.toString() ?? "", style: TextStyle(color: Colors.white),),
        ),
        onPointerDown: (PointerEvent event) {
          setState(() {
            _event = event;
          });
        },
        onPointerMove: (PointerEvent event) {
          setState(() {
            _event = event;
          });
        },
        onPointerUp: (PointerEvent event) {
          setState(() {
            _event = event;
          });
        },
      ),
    );
  }
}