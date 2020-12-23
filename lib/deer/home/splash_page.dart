import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/constant.dart';
import 'package:flutterapp/deer/util/image_util.dart';

/// @Date：2020/12/23
/// @Author：songdongliang
/// Desc：

class SplashPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((element) {
          precacheImage(ImageUtils.getAssetImage(element), context);
        });
      }
      _initSplash();
    });
  }

  void _initSplash() {
    // _subscription = Stream.value(1).
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

}