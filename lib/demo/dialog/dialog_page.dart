import 'package:flutter/material.dart';

import 'dialog_demo.dart';

class DialogPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dialog List"),),
      body: AlertDialogRoute()
    );
  }

}