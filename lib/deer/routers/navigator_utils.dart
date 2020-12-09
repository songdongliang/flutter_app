import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {

  // 不需要页面返回值的跳转
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(FocusNode());
    Routes.router.navigateTo(context, path, replace: replace,
        clearStack: clearStack, transition: TransitionType.native);
  }

  // 需要页面返回值的跳转
  static pushResult(BuildContext context, String path,
      Function(Object) function, {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(FocusNode());
    Routes.router.navigateTo(context, path,
        clearStack: clearStack, transition: TransitionType.native).then((result) {
          if (result == null) {
            return;
          }
          function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  // 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
  }

  // 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context, result);
  }

}