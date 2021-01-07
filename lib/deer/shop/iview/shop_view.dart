import 'package:flutterapp/deer/mvp/mvps.dart';
import 'package:flutterapp/deer/shop/models/user_entity.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
abstract class ShopIMvpView implements IMvpView {

  void setUser(UserEntity user);

  bool get isAccessibilityTest;
}