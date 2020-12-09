import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/deer/routers/login_router.dart';
import 'package:flutterapp/main.dart';

import 'abstract_router_provider.dart';

class Routes {

  static String home = "/home";

  // 子router管理集合
  static List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    // 这里可以设置路由not found页，这里先用首页替代
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => HomePage());
    // 主界面可以在此类中进行注册（可定义传参）
    router.define(home, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => HomePage()));
    // 其他公用界面也可以这样在这弄（可定义传参）
    // router.define(home, handler: Handler(
    //     handlerFunc: (BuildContext context, Map<String, List<String>> params) => MyApp()));
    // 每次初始化之前，先清空集合
    _listRouter.clear();
    // 各自路由模块在这统一添加
    _listRouter.add(LoginRouter());
    // 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }

}