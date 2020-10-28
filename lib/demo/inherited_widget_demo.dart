
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class InheritedContainer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _InheritedContainerState();

}

class _InheritedContainerState extends State<InheritedContainer> {



  InheritedModel inheritedModel;

  _incrementCount() async {
    setState(() {
      inheritedModel = InheritedModel(inheritedModel.count + 1);
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString("${inheritedModel.count}");
  }

  _reduceCount() async {
    setState(() {
      inheritedModel = InheritedModel(inheritedModel.count - 1);
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString("${inheritedModel.count}");
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    inheritedModel = InheritedModel(0);
    _readCounter().then((value) {
      setState(() {
        inheritedModel = InheritedModel(value);
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return InheritedContext(
        inheritedModel: inheritedModel,
        increment: _incrementCount,
        reduce: _reduceCount,
        child: Scaffold(
          appBar: AppBar(title: Text("InheritedWidgetTest"),),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                child: new Text('我们常使用的\nTheme.of(context).textTheme\nMediaQuery.of(context).size等\n就是通过InheritedWidget实现的',
                  style: new TextStyle(fontSize: 20.0),),
              ),
              TestWidgetA(),
              TestWidgetB(),
              TestWidgetC()
            ],
          ),
        )
    );
  }
  
}

/// 隔离 "+" "-" "value"三个widget
class TestWidgetA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final inheritedContext = InheritedContext.of(context);
    final inheritedModel = inheritedContext.inheritedModel;
    
    print('TestWidgetA 中count的值:  ${inheritedModel.count}');

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: RaisedButton(
        child: Text("+"),
        textColor: Colors.black,
        onPressed: inheritedContext.increment,
      ),
    );
  }

}

class TestWidgetB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final inheritedContext = InheritedContext.of(context);
    final inheritedModel = inheritedContext.inheritedModel;

    print('TestWidgetB 中count的值:  ${inheritedModel.count}');

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Text("当前值为: ${inheritedModel.count}", style: TextStyle(fontSize: 20),),
    );
  }

}

class TestWidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final inheritedContext = InheritedContext.of(context);
    final inheritedModel = inheritedContext.inheritedModel;

    print('TestWidgetC 中count的值:  ${inheritedModel.count}');

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: RaisedButton(
        child: Text('-'),
        textColor: Colors.black,
        onPressed: inheritedContext.reduce,
      ),
    );
  }

}

class InheritedContext extends InheritedWidget {

  final InheritedModel inheritedModel;

  final Function() increment;

  final Function() reduce;

  InheritedContext({
    Key key,
    @required this.inheritedModel,
    @required this.increment,
    @required this.reduce,
    @required Widget child
  }): super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedContext>();
  }

  @override
  bool updateShouldNotify(InheritedContext oldWidget) {
    return inheritedModel != oldWidget.inheritedModel;
  }

}

class InheritedModel {
  final int count;

  const InheritedModel(this.count);
}