import 'package:flutter/material.dart';
import 'package:flutterapp/deer/mvp/base_page_presenter.dart';
import 'package:flutterapp/deer/mvp/mvps.dart';
import 'package:flutterapp/deer/net/http_api.dart';
import 'package:flutterapp/deer/shop/iview/shop_view.dart';
import 'package:flutterapp/deer/shop/models/user_entity.dart';
import 'package:flutterapp/net/dio_util.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class ShopPagePresenter extends BasePagePresenter<ShopIMvpView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (view.isAccessibilityTest) {
        return;
      }

      // 接口请求例子
      asyncRequestNetwork<UserEntity>(
          Method.get,
          url: HttpApi.users,
        onSuccess: (data) {
            view.setUser(data);
        }
      );
    });
  }

}