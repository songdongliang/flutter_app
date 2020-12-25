import 'package:flutter/foundation.dart';

/// @Date：2020/12/3
/// @Author：songdongliang
/// Desc：
class Constant {

  /// debug，上线需要关闭
  /// app在运行release环境时， inProduction为true
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest  = false;

  static const String keyGuide = 'keyGuide';
  static const String theme = 'AppTheme';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

}