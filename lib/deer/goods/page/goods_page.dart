import 'package:flutter/material.dart';
import 'package:flutterapp/deer/goods/provider/good_page_provider.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:flutterapp/deer/widget/load_image.dart';
import 'package:provider/provider.dart';

/// @Date：2020/12/29
/// @Author：songdongliang
/// Desc：
class GoodsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _GoodsPageState();

}

class _GoodsPageState extends State<GoodsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  final List<String> _sortList = ['全部商品', '个人护理', '饮料', '沐浴洗护'
    , '厨房用具', '休闲食品', '生鲜水果', '酒水', '家庭清洁'];
  TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  final GlobalKey _addKey = GlobalKey();
  final GlobalKey _bodyKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();

  GoodsPageProvider provider = GoodsPageProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider(
        create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '搜索商品',
                icon: LoadAssetImage(
                    'goods/search',
                  key: const Key('search'),
                  width: 24.0,
                  height: 24.0,
                  color: _iconColor,
                ),
                onPressed: () {
                  // TODO 跳转到搜索商品
                }
            ),
            IconButton(
              tooltip: '添加商品',
                key: _addKey,
                icon: LoadAssetImage(
                    'goods/add',
                  key: const Key('add'),
                  width: 24.0,
                  height: 24.0,
                  color: _iconColor,
                ),
                onPressed: _showAddMenu
            )
          ],
        ),
        body: Column(
          key: _bodyKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Semantics(
              container: true,
              label: '选择商品类型',
              child: GestureDetector(
                key: _buttonKey,
                // 使用Selector避免同provider数据变化导致此处不必要的刷新
                child: Selector<GoodsPageProvider, int>(
                  selector: (_, provider) => provider.sortIndex,
                  builder: (_, sortIndex, __) {
                    // 只会触发sortIndex变化的刷新
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Gaps.hGap16,
                        Text(
                          _sortList[sortIndex],
                          style: TextStyles.textBold24,
                        ),
                        Gaps.hGap8,
                        LoadAssetImage(
                          'goods/expand',
                          width: 16,
                          height: 16,
                          color: _iconColor,
                        ),
                      ],
                    );
                  },
                ),
                onTap: () => _showSortMenu(),
              ),
            ),
            Gaps.vGap24,
            Container(
              // 隐藏点击效果
              padding: const EdgeInsets.only(left: 16.0),
              color: context.backgroundColor,
              child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(left: 0.0),
                unselectedLabelColor: context.isDark ? SColors.text_gray : SColors.text,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.only(right: 98.0 - 36.0),
                tabs: const <Widget>[
                  _TabView('在售', 0),
                  _TabView('待售', 1),
                  _TabView('下架', 2),
                ],
              ),
            ),
            Gaps.line,
            Expanded(
                child: PageView.builder(
                  key: const Key('pageView'),
                    itemBuilder: (_, int index) {
                      // TODO GoodsListPage
                    }
                ),
            )
          ],
        ),
      ),
    );
  }

  void _showAddMenu() {
    final RenderBox button = _addKey.currentContext.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  }

  void _showSortMenu() {

  }

  @override
  bool get wantKeepAlive => throw UnimplementedError();

}

class _TabView extends StatelessWidget {

  final String tabName;
  final int index;

  const _TabView(this.tabName, this.index);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 98.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tabName),
            Consumer<GoodsPageProvider>(
                builder: (_, provider, child) {
                  return Visibility(
                    visible: !(provider.goodCountList[index] == 0 || provider.index != index),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                            ' (${provider.goodCountList[index]}件)',
                          style: const TextStyle(fontSize: Dimens.font_sp12),
                        ),
                      ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}