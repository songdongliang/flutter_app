
import 'package:flutter/material.dart';
import 'package:flutterapp/demo/skin/redux/local_redux.dart';
import 'package:flutterapp/demo/skin/redux/theme_redux.dart';

class SDLState {

  /// 主题
  ThemeData themeData;

  /// 语言
  Locale locale;

  SDLState({this.themeData, this.locale});

}

SDLState appReducer(SDLState state, action) {
  return SDLState(
    themeData: themeDataReducer(state.themeData, action),
    locale: localeReducer(state.locale, action)
  );
}