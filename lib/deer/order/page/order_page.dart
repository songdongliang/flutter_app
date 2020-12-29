import 'package:flutter/material.dart';
import 'package:flutterapp/deer/order/provider/order_page_provider.dart';
import 'package:flutterapp/deer/util/image_util.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:provider/provider.dart';

/// @Date：2020/12/29
/// @Author：songdongliang
/// Desc：
class OrderPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _OrderPageState();

}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage>, SingleTickerProviderStateMixin {

  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  OrderPageProvider provider = OrderPageProvider();

  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  void _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage('order/xdd_n'), context);
    precacheImage(ImageUtils.getAssetImage('order/dps_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/dwc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/ywc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/yqx_s'), context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = context.isDark;
    return ChangeNotifierProvider(
        create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SafeArea(
                child: SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: isDark ? null : const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF5793FA), Color(0xFF4647FA)],
                        )
                      )
                  ),
                )
            ),
            NestedScrollView(
              key: const Key('order_list'),
                physics: const ClampingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) => _sliverBuilder(context),
                body: null
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

      )
    ];
  }

}