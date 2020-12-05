import 'package:flutter/material.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:flutterapp/demo/widgetDemo.dart';

/// @Date：2020/12/5
/// @Author：songdongliang
/// Desc：自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.backImg = 'assets/images/ic_back_black.png',
    this.actionName = '',
    this.onPressed,
    this.isBack = true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (_backgroundColor == null) {
      _backgroundColor = context.backgroundColor;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);


}
