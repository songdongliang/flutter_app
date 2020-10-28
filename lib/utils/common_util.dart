
import 'package:flutter/material.dart';
import 'package:flutterapp/demo/skin/style/sdl_style.dart';

class CommonUtils {

  static getThemeDataByIndex(int index) {
    return getThemeData(getThemeListColor()[index]);
  }

  static List<Color> getThemeListColor() {
    return [
      SDLColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }
}