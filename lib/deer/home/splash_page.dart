import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/deer/routers/login_router.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';
import 'package:flutterapp/deer/widget/load_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterapp/common/constant.dart';
import 'package:flutterapp/deer/util/image_util.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';

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
    _subscription = Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((event) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        NavigatorUtils.push(context, LoginRouter.loginPage);
      }
    });
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.backgroundColor,
      child: _status == 0 ? FractionallyAlignedSizedBox(
          child: const LoadAssetImage('logo'),
          heightFactor: 0.3,
        widthFactor: 0.33,
        leftFactor: 0.33,
        bottomFactor: 0,
      ) : Swiper(
          itemCount: _guideList.length,
        loop: false,
        key: const Key('swiper'),
        itemBuilder: (_, index) {
            return LoadAssetImage(
              _guideList[index],
              key: Key(_guideList[index]),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              format: ImageFormat.webp,
            );
        },
        onTap: (index) {
            if (index == _guideList.length - 1) {
              NavigatorUtils.push(context, LoginRouter.loginPage);
            }
        },
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

}