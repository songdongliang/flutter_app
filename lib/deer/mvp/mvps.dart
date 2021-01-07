import 'package:flutter/material.dart';
import 'package:flutterapp/deer/mvp/i_lifecycle.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
abstract class IMvpView {

  BuildContext getContext();
  /// 显示Progress
  void showProgress();

  void closeProgress();

  void showToast(String message);

}

abstract class IPresenter extends ILifecycle {

}