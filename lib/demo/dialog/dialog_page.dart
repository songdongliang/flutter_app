import 'package:flutter/material.dart';
import 'package:flutterapp/utils/log.dart';

import 'dialog_demo.dart';

class DialogPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Log.d("This is a DialogPage");
    return Scaffold(
      appBar: AppBar(title: Text("Dialog List"),),
      body: AlertDialogRoute()
    );
  }

}