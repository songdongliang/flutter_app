import 'package:flutter/material.dart';

/// @Date：2020/12/5
/// @Author：songdongliang
/// Desc：
extension ThemeExtension on BuildContext {
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
}