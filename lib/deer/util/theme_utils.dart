import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/colors.dart';

/// @Date：2020/12/5
/// @Author：songdongliang
/// Desc：
class ThemeUtils {

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getIconColor(BuildContext context) {
    return isDark(context) ? SColors.dark_text : null;
  }

  static Color getKeyboardActionsColor(BuildContext context) {
    return isDark(context) ? SColors.dark_bg_color : Colors.grey[200];
  }

}

extension ThemeExtension on BuildContext {
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  bool get isDark => ThemeUtils.isDark(this);
}