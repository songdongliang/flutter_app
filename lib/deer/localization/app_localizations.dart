import 'package:flutter/material.dart';

/// @Date：2020/12/5
/// @Author：songdongliang
/// Desc：
class AppLocalizations {

  final String localeName;

  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();

  }

}