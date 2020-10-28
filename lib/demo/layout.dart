import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          Container(
            width: 90,
            height: 90,
            color: Colors.green,
          ),
          Container(
            width: 80,
            height: 80,
            color: Colors.blue,
          ),
        ]
    );
  }
}

class PositionedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 100,
          child: Container(
            color: Colors.red,
            child: Text('first'),
          ),
        ),
        Positioned(
          left: 100,
          child: Container(
            color: Colors.green,
            child: Text('second'),
          ),
        ),
        Positioned(
          top: 200,
          right: 0,
          child: Container(
            color: Colors.blue,
            child: Text('third'),
          ),
        )
      ],
    );
  }
}

class RowColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1.5,
      heightFactor: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.yellow,
                width: 100.0,
                height: 100.0,
              ),
              Container(
                color: Colors.red,
                width: 100.0,
                height: 100.0,
              )
            ],
          ),
          Container(
            color: Colors.blue,
            width: 100.0,
            height: 100.0,
          ),
          Container(
            color: Colors.green,
            width: 100.0,
            height: 100.0,
          )
        ],
      ),
    );
  }

}