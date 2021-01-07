import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutterapp/deer/order/page/order_info_page.dart';
import 'package:flutterapp/deer/order/page/order_page.dart';
import 'package:flutterapp/deer/order/page/order_track_page.dart';
import 'package:flutterapp/deer/routers/abstract_router_provider.dart';

/// @Date：2021/1/5
/// @Author：songdongliang
/// Desc：
class OrderRouter implements IRouterProvider {

  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderTrackPage = '/order/track';

  @override
  void initRouter(FluroRouter router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, __) => OrderPage()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_, __) => OrderInfoPage()));
    router.define(orderTrackPage, handler: Handler(handlerFunc: (_, __) => OrderTrackPage()));
  }

}
