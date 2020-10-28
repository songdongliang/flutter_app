import 'package:flutter/material.dart';

class ClipRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ClipState();

}

class _ClipState extends State<ClipRoute> {

  List<String> _tags = ['Apple', 'Banana', 'Lemon'];

  String _action = "hello";

  List<String> _selected = [];

  String _choice = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          // 行间隔
          runSpacing: 8.0,
          children: <Widget>[
            Chip(
              label: Text("life")
            ),
            Chip(
              label: Text("Sunset"),
              backgroundColor: Colors.orange,
            ),
            Chip(
              label: Text("TuHao"),
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text("土"),
              ),
            ),
            Chip(
              label: Text("网络图片"),
              avatar: CircleAvatar(
                backgroundImage: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592368508174&di=2b3d310c72aed1cf179d415bb0e05b5f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg"),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _tags.map((tag) => Chip(
                  label: Text(tag),
                  onDeleted: (){
                    setState(() {
                      _tags.remove(tag);
                    });
                  },
                )).toList(),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              width: double.infinity,
              child: Text("ActionChip: $_action"),
            ),
            Wrap(
              spacing: 8.0,
              children: _tags.map((tag) => ActionChip(
                label: Text(tag),
                onPressed: (){
                  setState(() {
                    _action = tag;
                  });
                },
              )).toList(),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              width: double.infinity,
              child: Text("FilterChip: ${_selected.toString()}"),
            ),
            Wrap(
              spacing: 8.0,
              children: _tags.map((tag) => FilterChip(
                label: Text(tag),
                selected: _selected.contains(tag),
                onSelected: (value){
                  setState(() {
                    if (value) {
                      _selected.add(tag);
                    } else {
                      _selected.remove(tag);
                    }
                  });
                },
              )).toList(),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              width: double.infinity,
              child: Text("ChoiceChip: $_choice"),
            ),
            Wrap(
              spacing: 8.0,
              children: _tags.map((tag) => ChoiceChip(
                label: Text(tag),
                selected: _choice == tag,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _choice = tag;
                    } else {
                      _choice = "";
                    }
                  });
                },
              )).toList(),
            ),
          ],
        )
      ],
    );
  }

}