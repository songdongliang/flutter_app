
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ScrollToIndexPage2 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ScrollToIndexPageState();

}

class _ScrollToIndexPageState extends State<ScrollToIndexPage2> {

  GlobalKey scrollKey = GlobalKey();

  ScrollController scrollController = ScrollController();

  List<ItemModel> dataList = List();

  @override
  void initState() {
    dataList.clear();
    for (int i = 0; i < 100;i++) {
      dataList.add(ItemModel(i));
    }
    super.initState();
  }

  _scrollToIndex() {
    var item = dataList[12];

    // 获取renderBox
    RenderBox renderBox = item.globalKey.currentContext.findRenderObject();

    // 获取位置偏移, 基于Scroll
    double dy = renderBox.localToGlobal(Offset.zero,
        ancestor: scrollKey.currentContext.findRenderObject()).dy;
    
    // 计算真实偏移
    var offset = dy + scrollController.offset;
    
    scrollController.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.linear);

    print('$dy*********${scrollController.offset}*******$offset');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrollToIndexPage2"),
      ),
      body: Container(
        child: SingleChildScrollView(
          key: scrollKey,
          controller: scrollController,
          child: Column(
            children: dataList.map<Widget>((data) => CardItem(data, key: data.globalKey,)
            ).toList(),
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: (){
            _scrollToIndex();
          },
          child: Text("scroll to index 12"),
        )
      ],
    );
  }

}

class CardItem extends StatelessWidget {

  final random = math.Random();

  final ItemModel itemModel;

  CardItem(this.itemModel, {key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: math.max(300 * random.nextDouble(), 50),
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Text("Item ${itemModel.index}"),
        ),
      ),
    );
  }
}

class ItemModel {
  /// 这个key是关键
  GlobalKey globalKey = GlobalKey();

  final int index;

  ItemModel(this.index);
}