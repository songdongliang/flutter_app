import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutterapp/deer/login/page/register_page.dart';
import 'package:flutterapp/deer/routers/abstract_router_provider.dart';

/// @Date：2020/12/9
/// @Author：songdongliang
/// Desc：
class LoginRouter implements IRouterProvider {


  static String registerPage = '/login/register';

  @override
  void initRouter(FluroRouter router) {
    router.define(registerPage, handler: Handler(handlerFunc: (_, __) => RegisterPage()));
  }

}