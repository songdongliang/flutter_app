import 'package:flutter/material.dart';
import 'package:flutterapp/deer/mvp/base_page.dart';
import 'package:flutterapp/deer/mvp/power_presenter.dart';
import 'package:flutterapp/deer/order/iview/order_search_iview.dart';
import 'package:flutterapp/deer/order/models/search_entity.dart';
import 'package:flutterapp/deer/order/presenter/order_search_presenter.dart';
import 'package:flutterapp/deer/provider/base_list_provider.dart';
import 'package:flutterapp/deer/shop/iview/shop_view.dart';
import 'package:flutterapp/deer/shop/models/user_entity.dart';
import 'package:flutterapp/deer/shop/presenter/shop_presenter.dart';
import 'package:flutterapp/deer/widget/my_refresh_list.dart';
import 'package:flutterapp/deer/widget/search_bar.dart';
import 'package:flutterapp/deer/widget/state_layout.dart';
import 'package:provider/provider.dart';

/// @Date：2021/1/7
/// @Author：songdongliang
/// Desc：
class OrderSearchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _OrderSearchPageState();

}

class _OrderSearchPageState extends State<OrderSearchPage>
    with BasePageMixin<OrderSearchPage, PowerPresenter>
    implements OrderSearchIMvpView, ShopIMvpView {

  String _keyword;
  int _page = 1;

  OrderSearchPresenter _orderSearchPresenter;
  ShopPagePresenter _shopPagePresenter;

  @override
  void initState() {
    // 默认为加载中状态，本页面场景默认为空
    provider.setStateTypeNotNotify(StateType.empty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<SearchItem>>(
        create: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: '请输入手机号或姓名查询',
          onPressed: (text) {
            if (text.isEmpty) {
              showToast('搜索关键字不能为空！');
              return;
            }
            _keyword = text;
            provider.setStateType(StateType.loading);
            _page = 1;
            _orderSearchPresenter.search(_keyword, _page, true);
          },
        ),
        body: Consumer<BaseListProvider<SearchItem>>(
            builder: (_, provider, __) {
              return DeerListView(
                key: const Key('order_search_list'),
                itemCount: provider.list.length,
                stateType: provider.stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                itemExtent: 50.0,
                hasMore: provider.hasMore,
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(provider.list[index].name),
                  );
                },
              );
            }
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _page = 1;
    await _orderSearchPresenter.search(_keyword, _page, false);
  }

  Future<void> _loadMore() async {
    _page++;
    await _orderSearchPresenter.search(_keyword, _page, false);
  }

  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _orderSearchPresenter = OrderSearchPresenter();
    _shopPagePresenter = ShopPagePresenter();
    powerPresenter.requestPresenter([_orderSearchPresenter, _shopPagePresenter]);
    return powerPresenter;
  }

  @override
  bool get isAccessibilityTest => false;

  @override
  BaseListProvider<SearchItem> get provider => BaseListProvider<SearchItem>();

  @override
  void setUser(UserEntity user) {
    showToast(user.name);
  }

}