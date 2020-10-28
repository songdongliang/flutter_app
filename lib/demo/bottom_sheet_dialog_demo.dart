import 'package:flutter/material.dart';

showBottomSheet2(BuildContext context) async {
  int index = await _showModalBottomSheet(context);
  print("点击了: $index");
}

Future<int> _showModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: (){
                  Navigator.of(context).pop(index);
                },
              );
            }
        );
      });
}