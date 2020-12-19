import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// @Date：2020/12/19
/// @Author：songdongliang
/// Desc：对于Web应用程序，为了提高性能，可以禁用页面过渡动画。
/// https://medium.com/flutter/improving-perceived-performance-with-image-placeholders-precaching-and-disabled-navigation-6b3601087a2b
class NoTransitionsOnWeb extends PageTransitionsTheme {

  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (kIsWeb) return child;
    return super.buildTransitions(route, context, animation, secondaryAnimation, child);
  }
}