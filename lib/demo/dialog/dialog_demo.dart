import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterapp/demo/advance_dialog_demo.dart';
import 'package:flutterapp/demo/bottom_sheet_dialog_demo.dart';
import 'package:flutterapp/demo/dialog/dialog_loading.dart';
import 'package:flutterapp/demo/dialog/dialog_package.dart';

class AlertDialogRoute extends StatelessWidget {

  Future<bool> showDialog1(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "提示",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff33394E),
              fontSize: 17
            ),
          ),
          content: Text(
              "您确定要删除吗",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff474f66),
              fontSize: 14
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => {
                Navigator.of(context).pop()
              },
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () => {
                Navigator.of(context).pop(true)
              },
            )
          ],
        );
      });
  }

  Future<Void> showAlertDialog(BuildContext context) async {
    bool delete = await showDialog1(context);
    if (delete == null) {
      print("取消删除");
    } else {
      print("确认删除");
    }
  }

  showSimpleDialog(BuildContext context) async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("请选择语言"),
        children: <Widget>[
          SimpleDialogOption(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text("中文简体"),
            ),
            onPressed: (){
              Navigator.of(context).pop(1);
            },
          ),
          SimpleDialogOption(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text("美式英语"),
            ),
            onPressed: (){
              Navigator.of(context).pop(2);
            },
          )
        ],
      );
    });
    if (i != null) {
      print("选择了：${i == 1 ? "中文简体": "美式英语"}");
    }
  }

  showListDialog(BuildContext context) async {
    int index = await showDialog<int>(
        context: context,
        builder: (BuildContext context){

          var child = Container(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(title: Text("请选择"),),
                Expanded(
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          title: Text("$index"),
                          onTap: () {
                            Navigator.of(context).pop(index);
                          },);
                      }),
                )
              ],
            ),
          );
          return Dialog(child: child);
        });
    if (index != null) {
      print("点击了: $index");
    }
  }

  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder
  }) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation){
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(
            child: Builder(
              builder: (BuildContext context) {
                return theme != null ? Theme(data: theme, child: pageChild,) : pageChild;
              },
            ),
          );
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black87,
        transitionDuration: const Duration(milliseconds: 150),
        transitionBuilder: _buildMaterialDialogTransitions
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    print("child: " + child.toStringDeep());
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  showCustomerDialog(BuildContext context) async {
    bool delete = await showCustomDialog<bool>(
        context: context, builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
    });
    if (delete != null) {
      print(delete ? "确定" : "取消");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("AlertDialog"),
          onPressed: () {
            showAlertDialog(context);
          }
        ),
        RaisedButton(
          child: Text("SimpleDialog"),
          onPressed: (){
            showSimpleDialog(context);
          },
        ),
        RaisedButton(
          child: Text("ListDialog"),
          onPressed: (){
            showListDialog(context);
          },
        ),
        RaisedButton(
          child: Text("CustomDialog"),
          onPressed: (){
            showCustomerDialog(context);
          },
        ),
        RaisedButton(
          child: Text("CheckBoxDialog"),
          onPressed: (){
            showDeleteConfirmDialog(context);
          },
        ),
        RaisedButton(
          child: Text("BottomSheetDialog"),
          onPressed: () {
            showBottomSheet2(context);
          },
        ),
        RaisedButton(
          child: Text("LoadingDialog"),
          onPressed: () {
            showLoadingDialog(context);
          },
        ),
        Text("下边的为统一风格的"),
        RaisedButton(
          child: Text("LoadingDialog"),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => DialogLoadingPage()));
            showDialog(context: context, builder: (_) => DialogLoadingPage());
          },
        ),
        RaisedButton(
          child: Text("带标题的"),
          onPressed: () {
            showDialog(
                context: context,
              barrierDismissible: false,
              child: YDDialog(
                title: "标题",
                content: "我系渣渣灰，我系咕天落",
                outsideDismiss: false,
                isCancel: true,
                cancelColor: Color(0xff8a8c99),
                confirmColor: Color(0xff33394E),
                confirmCallback: () {
                  print("确定");
                },
                cancelCallback: () {
                  print("取消");
                },
              ),
            );
          },
        ),
      ],
    );
  }

}