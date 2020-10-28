import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshDemoPage2 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RefreshDemoPage2State();

}

class _RefreshDemoPage2State extends State<RefreshDemoPage2> {

  final int pageSize = 20;

  final ScrollController scrollController = ScrollController();

  final List<String> dataList = List();

  bool disposed = false;

  Future<void> refresh() async {
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

  Future<void> loadMore() async {
    await Future.delayed(Duration(seconds: 2));

    for (int i = 0;i < pageSize;i++) {
      dataList.add("loadMore");
    }
    if (disposed) {
      return;
    }

    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("didChangeDependencies()");

    Future.delayed(Duration(milliseconds: 500), (){
      scrollController.animateTo(-141, duration: Duration(milliseconds: 600), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RefreshDemoPage2"),
      ),
      body: Container(
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollEndNotification) {
              if (scrollController.position.pixels > 0
                  && scrollController.position.pixels == scrollController.position.maxScrollExtent) {
                loadMore();
              }
            }
            return false;
          },
          child: CustomScrollView(
            controller: scrollController,
            /// 回弹效果
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[
              //控制显示刷新的CupertinoSliverRefreshControl
              CupertinoSliverRefreshControl(
                refreshIndicatorExtent: 100,
                refreshTriggerPullDistance: 140,
                onRefresh: refresh,
              ),
              SliverSafeArea(
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (dataList.length == index) {
                              return Container(
                                margin: EdgeInsets.all(16),
                                child: Align(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Card(
                              child: Container(
                                height: 60,
                                alignment: Alignment.centerLeft,
                                child: Text("Index $index ${dataList[index]}"),
                              ),
                            );
                          },
                        childCount: dataList.length >= pageSize ? dataList.length + 1 : dataList.length
                      )
                  )
              )
            ],
          ),
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