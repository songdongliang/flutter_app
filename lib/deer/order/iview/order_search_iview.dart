import 'package:flutterapp/deer/mvp/mvps.dart';
import 'package:flutterapp/deer/order/models/search_entity.dart';
import 'package:flutterapp/deer/provider/base_list_provider.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
abstract class OrderSearchIMvpView implements IMvpView {

  BaseListProvider<SearchItem> get provider;

}