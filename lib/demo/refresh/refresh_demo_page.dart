import 'package:flutter/material.dart';

class RefreshDemoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RefreshDemoPageState();

}

class _RefreshDemoPageState extends State<RefreshDemoPage> {

  final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();

  final ScrollController scrollController = ScrollController();

  List<String> dataList = List();

  final int pageSize = 30;

  bool disposed = false;

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));

    for (int i = 0; i < pageSize; i++) {
      dataList.add("loadMore");
    }
    if (disposed) {
      return;
    }

    setState(() {

    });
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));

    dataList.clear();
    for (int i = 0; i < pageSize; i++) {
      dataList.add("refresh");
    }
    if (disposed) {
      return;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    Future.delayed(Duration(seconds: 0), (){
      refreshKey.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RefreshDemoPage"),
      ),
      body: Container(
        child: RefreshIndicator(
          key: refreshKey,
            child: Container(
              child: ListView.builder(
                /// 保持listview任何情况下都能滑动，解决在RefreshIndicator的兼容问题
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                    if (dataList.length == index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Align(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Card(
                      child: Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text("Item ${dataList[index]} $index"),
                      ),
                    );
                },
                itemCount: dataList.length >= pageSize ? dataList.length + 1 : dataList.length,
                controller: scrollController,
              ),

            ),
            /// 下拉刷新触发，返回的是一个future
            onRefresh: onRefresh,
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

}