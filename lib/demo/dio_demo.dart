import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioGetRoute extends StatelessWidget {
  
  Dio dio = Dio();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio Get"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response res = snapshot.data;
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              // 请求成功
              print(res.data);
              return ListView(
                children: res.data.map<Widget>((e) =>
                    ListTile(title: Text(e["full_name"]),)
                ).toList(),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

}