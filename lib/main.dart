import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/demo/combination/TurnBoxRoute.dart';
import 'package:flutterapp/demo/combination/gradinent_button_page.dart';
import 'package:flutterapp/demo/dialog/dialog_page.dart';
import 'package:flutterapp/demo/keyboard/keyboard_demo_page.dart';
import 'package:flutterapp/demo/provider/counter_home_page.dart';
import 'package:flutterapp/demo/provider/my_change_notifier.dart';
import 'package:flutterapp/demo/refresh/refresh_demo_page.dart';
import 'package:flutterapp/demo/refresh/refresh_demo_page2.dart';
import 'package:flutterapp/demo/scroll/scroll_to_index_page2.dart';
import 'package:flutterapp/demo/skin/page/show_page.dart';
import 'package:flutterapp/demo/skin/redux/SDLState.dart';
import 'package:flutterapp/demo/stick/stick_demo_page.dart';
import 'package:flutterapp/demo/text/text_line_height_page.dart';
import 'package:flutterapp/utils/common_util.dart';
import 'package:flutterapp/utils/log.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'demo/bubble/bubble_demo_page.dart';
import 'demo/http_chunk_demo.dart';
import 'demo/image/simple_image_page.dart';
import 'demo/painter/chess_board_page.dart';
import 'demo/scroll/scroll_to_index_page.dart';
import 'demo/skin/page/switch_page.dart';
import 'demo/transform/transform_demo_page.dart';

//final store = Store<CountState>(reducer, initialState: CountState.initState());



void main() {

  final _store = Store<SDLState>(appReducer,
      initialState: SDLState(
          themeData: CommonUtils.getThemeDataByIndex(0),
          locale: Locale('zh', 'CH'))
  );

  Log.init();
 runApp(ChangeNotifierProvider(
     create: (context) => MyChangeNotifier(),
    child: MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Song App',
      home: HomePage(),
      routes: routers,
    ),)
 );
//   runApp(StoreProvider(
//     store: _store,
//     child: StoreBuilder<SDLState>(
//         builder: (context, store) {
//         return new MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: store.state.themeData,
//             title: 'Song App',
//             home: HomePage(),
//             routes: routers,
//           );
//     })
//   ));
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var routerList = routers.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(routerList[index]);
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: Text(routerList[index]),
                  ),
                ),
              );
            },
          itemCount: routerList.length,
        ),
      ),
    );
  }

}

Map<String, WidgetBuilder> routers = {
  "多点下载": (context) {
    return HttpChunkRoute();
  },
//  "Redux": (context) => ReduxDemo(store),
  "换肤": (context) => ShowPage(),
  "switch_page": (context) => SwitchPage(),
  "滑动到指定位置的Item": (context) => ScrollToIndexPage(),
  "滑动到指定位置的Item 2": (context) => ScrollToIndexPage2(),
  "组合的一个点击出现水波纹的Button": (context) => GradientButtonRoute(),
  "组合旋转": (context) => TurnBoxRoute(),
  "最定义绘制-棋盘展示": (context) => ChessBoardPage(),
  "TransformImage": (context) => TransformDemoPage(),
  "行间距": (context) => TextLineHeightPage(),
  "简单下拉刷新": (context) => RefreshDemoPage(),
  "简单下拉刷新2": (context) => RefreshDemoPage2(),
  "气泡弹窗": (context) => BubbleDemoPage(),
  "监听键盘弹起": (context) => KeyboardDemoPage(),
  "简单模仿Image组件": (context) => SimpleImagePage(),
  "dialog列表": (context) => DialogPage(),
  "Stick悬浮": (context) => StickDemoPage(),
  "Provider计数器": (context) => ProviderTestPage()
};



