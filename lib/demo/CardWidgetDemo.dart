import 'package:flutter/material.dart';

class CardWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white30,
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('今天是个好日子'),
            subtitle: Text('你说是不是啊'),
            leading: Icon(
              Icons.filter_1,
              color: Colors.lightBlue,
            ),
          ),
          Divider(color: Colors.grey,),
          ListTile(
            title: Text(
              '明天也是好日子',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '你说是不是啊'
            ),
            leading: Icon(
              Icons.filter_2,
              color: Colors.lightBlue,
            ),
          ),
          Divider(color: Colors.grey,),
          ListTile(
            title: Text('后天还是好日子'),
            subtitle: Text('你说是不是啊'),
            leading: Icon(
              Icons.filter_3,
              color: Colors.lightBlue,
            ),
          )
        ],
      ),
    );
  }

}