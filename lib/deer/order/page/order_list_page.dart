import 'package:flutter/material.dart';
import 'package:flutterapp/deer/order/provider/order_page_provider.dart';
import 'package:flutterapp/deer/util/change_notifier_mixin.dart';
import 'package:flutterapp/deer/widget/state_layout.dart';
import 'package:provider/provider.dart';

/// @Date：2020/12/30
/// @Author：songdongliang
/// Desc：
class OrderListPage extends StatefulWidget {

  final int index;

  const OrderListPage({
    Key key,
    @required this.index,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderListPageState();

}

class _OrderListPageState extends State<OrderListPage> with AutomaticKeepAliveClientMixin<OrderListPage>, ChangeNotifierMixin<OrderListPage> {

  final ScrollController _controller = ScrollController();
  final StateType _stateType = StateType.loading;
  /// 是否正在加载数据
  bool _isLoading = false;
  final int _maxPage = 3;
  int _page = 1;
  int _index = 0;
  List<String> _list = <String>[];

  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0, /// 默认是40， 多添加的80为header高度
        child: Consumer<OrderPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，
              /// 避免一处滑动，5个Tab中的列表同步滑动
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>('$_index'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  /// SliverAppBar的expandedHeight高度，避免重叠
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)
                ),
                child
              ],
            );
          },
        ),
      )
    );
  }

  @override
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier() {
    return {_controller: null};
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(10, (index) => 'newItem: $index');
      });
    });
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future<void> _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (index) => 'newItem: $index'));
        _page++;
        _isLoading = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

}