import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/constant.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/routers/web_page_transitions.dart';

/// @Date：2020/12/19
/// @Author：songdongliang
/// Desc：
extension ThemeModeExtension on ThemeMode {
  String get value => ['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {

  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      errorColor: isDarkMode ? SColors.dark_red : SColors.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? SColors.dark_app_main : SColors.app_main,
      accentColor: isDarkMode ? SColors.dark_app_main : SColors.app_main,
      // tab指示器颜色
      indicatorColor: isDarkMode ? SColors.dark_app_main : SColors.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? SColors.dark_bg_color : Colors.white,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? SColors.dark_material_bg : Colors.white,
      // 文字选择色 （输入框复制粘贴菜单）
      textSelectionColor: SColors.app_main.withAlpha(70),
      // 用于调整当前选定的文本部分的句柄的颜色
      textSelectionHandleColor: SColors.app_main,
      // 稳定发行版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: SColors.app_main.withAlpha(70),
        selectionHandleColor: SColors.app_main
      ),
      textTheme: TextTheme(
        // TextField输入文字颜色
        subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        bodyText1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        subtitle2: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? SColors.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? SColors.dark_line : SColors.line,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      pageTransitionsTheme: NoTransitionsOnWeb()
    );
  }

}