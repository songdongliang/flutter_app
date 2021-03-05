import 'package:flutter/material.dart';
import 'package:flutterapp/deer/routers/login_router.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';
import 'package:flutterapp/demo/skin/style/sdl_style.dart';

/// @Date：2021/2/1
/// @Author：songdongliang
/// Desc：
class LifeStyleTestWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LifeStyleTestState();

}

class _LifeStyleTestState extends State<LifeStyleTestWidget> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPersistentFrameCallback((_){
      print("实时Frame绘制回调");//每帧都回调
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("$state");
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // 它会在当前 Frame 绘制完成后进行进行回调，并且只会回调一次，如果要再次监听则需要再设置一次。
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("单次Frame绘制回调");//只回调一次
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("测试生命周期"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              print("parent onTap");
            },
            onDoubleTap: () {
              print("parent onDoubleTap");
            },
            child: FlatButton(onPressed: () {
              // setState(() {
              //
              // });
              // NavigatorUtils.push(context, LoginRouter.registerPage);
            }, child: Text("跳转")),
          ),
        ],
      ),
    );
  }

}