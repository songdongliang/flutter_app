import 'package:flutter/material.dart';

class FutureBuilderDemo extends StatelessWidget {

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是网上冲浪获取的数据");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

}

class StreamBuilderDemo extends StatelessWidget {

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: counter(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("没有stream");
            case ConnectionState.waiting:
              return Text("等待数据");
            case ConnectionState.active:
              return Text("content: ${snapshot.data}");
            case ConnectionState.done:
              return Text("Stream已关闭");
          }
          return null;
        },
      ),
    );
  }

}