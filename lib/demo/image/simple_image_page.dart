import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/demo/image/simple_image.dart';

class SimpleImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SimpleImagePage"),
      ),
      body: Column(
        children: <Widget>[
          SimpleImage(
            key: GlobalKey(),
            imageProvider: NetworkImage("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
          )
        ],
      ),
    );
  }

}