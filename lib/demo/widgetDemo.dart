import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {

  MyAppbar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0, // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      // Row是水平方向的线性布局
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              tooltip: WordPair.random().toString(),
              onPressed: null
          ),
          new Expanded(child: title),
          new IconButton(
              icon: new Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null
          )
        ]
      ),
    );
  }

}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppbar(
            title: new Text(
              'Example Title',
                style: Theme.of(context).primaryTextTheme.headline6
            ),
          ),
          new Expanded(
              child: new Container(
                  child: new Center(
                      child: new Text('Hello world'),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffff0000)
                  ),
              )
          )
        ],
      ),
    );
  }

}