import 'package:flutter/material.dart';

class ButtonListDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        RaisedButton(
          child: Text("RaisedButton"),
          onPressed: (){},
        ),
        FlatButton(
          child: Text("FlatButton"),
          onPressed: (){},
        ),
        OutlineButton(
          child: Text("OutlineButton"),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () {},
        ),
        RaisedButton.icon(
          icon: Icon(Icons.send),
          label: Text("send"),
          onPressed: (){},
        ),
        FlatButton.icon(
            onPressed: null,
            icon: Icon(Icons.add),
            label: Text("添加")
        ),
        OutlineButton.icon(
            onPressed: null,
            icon: Icon(Icons.info),
            label: Text("详情")
        ),
        FlatButton(
          color: Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          child: Text('Submit'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: (){},
        ),
        RaisedButton( // 有浮雕阴影
          elevation: 6.0, // 正常情况下的阴影
          highlightElevation: 2.0, // 按下时的阴影
          disabledElevation: 0, // 禁用时的阴影
          color: Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          child: Text('Submit'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: (){},
        )
      ],
    );
  }

}
