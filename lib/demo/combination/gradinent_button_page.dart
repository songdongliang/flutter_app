
import 'package:flutter/material.dart';
import 'package:flutterapp/demo/combination/gradient_button.dart';

class GradientButtonRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _GradientButtonRouteState();

}

class _GradientButtonRouteState extends State<GradientButtonRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gradient Button List"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50.0,
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              colors: [Colors.lightGreen, Colors.green],
              height: 50.0,
              child: Text("Submit"),
              onPressed: onTap,
            ),
            GradientButton(
              colors: [Colors.lightBlue[300], Colors.blue],
              height: 50.0,
              child: Text("Submit"),
              onPressed: onTap,
            )
          ],
        ),
      ),
    );
  }

  onTap() {
    print("button click");
  }

}