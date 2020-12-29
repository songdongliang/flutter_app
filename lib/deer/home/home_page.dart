import 'package:flutter/material.dart';
import 'package:flutterapp/deer/goods/page/goods_page.dart';
import 'package:flutterapp/deer/home/provider/home_provider.dart';
import 'package:flutterapp/deer/order/page/order_page.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/shop/page/shop_page.dart';
import 'package:flutterapp/deer/statistics/page/statistics_page.dart';
import 'package:flutterapp/deer/util/double_tap_back_exit_app.dart';
import 'package:flutterapp/deer/widget/load_image.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:provider/provider.dart';

/// @Date：2020/12/29
/// @Author：songdongliang
/// Desc：
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  static const double _imageSize = 25.0;

  List<Widget> _pageList;
  final List<String> _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _initData() {
    _pageList = [
      OrderPage(),
      GoodsPage(),
      StatisticsPage(),
      const ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize, color: SColors.unselected_item_color,),
          LoadAssetImage('home/icon_order', width: _imageSize, color: SColors.app_main,)
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: SColors.unselected_item_color,),
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: SColors.app_main,)
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: SColors.unselected_item_color,),
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: SColors.app_main,)
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize, color: SColors.unselected_item_color,),
          LoadAssetImage('home/icon_shop', width: _imageSize, color: SColors.app_main,)
        ],
      ];
      _list = List.generate(_tabImages.length, (index) => BottomNavigationBarItem(
          icon: _tabImages[index][0],
        activeIcon: _tabImages[index][1],
        label: _appBarTitles[index]
      ));
    }
    return _list;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const _tabImagesDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize,),
          LoadAssetImage('home/icon_order', width: _imageSize, color: SColors.dark_app_main,)
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize,),
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: SColors.dark_app_main,)
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize,),
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: SColors.dark_app_main,)
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize,),
          LoadAssetImage('home/icon_shop', width: _imageSize, color: SColors.dark_app_main,)
        ],
      ];

      _listDark = List.generate(_tabImagesDark.length, (index) => BottomNavigationBarItem(
          icon: _tabImagesDark[index][0],
        activeIcon: _tabImagesDark[index][1],
        label: _appBarTitles[index]
      ));
    }
    return _listDark;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
          child: Scaffold(
            bottomNavigationBar: Consumer<HomeProvider>(
                builder: (_, provider, __) {
                  return BottomNavigationBar(
                    backgroundColor: context.backgroundColor,
                      items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                    type: BottomNavigationBarType.fixed,
                    currentIndex: provider.value,
                    elevation: 5.0,
                    iconSize: 21.0,
                    selectedFontSize: Dimens.font_sp10,
                    unselectedFontSize: Dimens.font_sp10,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: isDark ? SColors.dark_unselected_item_color : SColors.unselected_item_color,
                    onTap: (index) => _pageController.jumpToPage(index),
                  );
                }
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int index) => provider.value = index,
              children: _pageList,
            ),
          )
      ),
    );
  }

}