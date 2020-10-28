import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('查看详情'),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => SecondScreen()
              ))
        },
      ),
    );
  }

}

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

}