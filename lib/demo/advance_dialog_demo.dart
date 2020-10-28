import 'package:flutter/material.dart';


class StatefulBuilder extends StatefulWidget {

  const StatefulBuilder({
    Key key,
    @required this.builder
}): assert(builder != null), super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => _StatefulBuilderState();

}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);

}

showDeleteConfirmDialog(BuildContext context) async {
  bool isDelete = await showDeleteConfirmDialog3(context);
  if (isDelete == null) {
    print("取消了");
  } else {
    print("同时删除子目录: $isDelete");
  }
}

Future<bool> showDeleteConfirmDialog3(BuildContext context) {
  bool _withTree = false; // 记录复选框是否选中
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗？"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录?"),
                  Builder(builder: (BuildContext context) {
                    return Checkbox(
                      value: _withTree,
                      onChanged: (v) {
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                    );
                  })
//                  StatefulBuilder(builder: (context, _setState) {
//                    return Checkbox(
//                      value: _withTree,
//                      onChanged: (v) {
//                        _setState((){
//                          // 更新选中状态
//                          _withTree = !_withTree;
//                        });
//                      },
//                    );
//                  })

//                  DialogCheckbox(
//                    value: _withTree,
//                    onChanged: (bool v) {
//                      // 更新选中状态
//                      _withTree = !_withTree;
//                    },
//                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: (){
                Navigator.of(context).pop(_withTree);
              },
            )
          ],
        );
      });
}

class DialogCheckbox extends StatefulWidget {

  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final ValueChanged<bool> onChanged;

  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();

}

class _DialogCheckboxState extends State<DialogCheckbox> {

  bool value ;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        // 将选中状态以事件形式抛出
        widget.onChanged(v);
        setState(() {
          value = v;
        });
      },
    );
  }

}

showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context){
        return UnconstrainedBox( // 先用这个抵消掉弹窗自带的宽度
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 26),
                    child: Text("正在加载，请稍后..."),
                  )
                ],
              ),
            ),
          ),
        );
      });
}