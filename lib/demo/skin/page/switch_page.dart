import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/demo/skin/redux/SDLState.dart';
import 'package:flutterapp/demo/skin/redux/theme_redux.dart';
import 'package:flutterapp/utils/common_util.dart';

class SwitchPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<SDLState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Switch Page"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("如下皮肤可以切换"),
                SizedBox(height: 50,),
                Expanded(
                  child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: FlatButton(
                            color: CommonUtils.getThemeListColor()[index],
                            child: Text(CommonUtils.getThemeListColor()[index].toString()),
                            onPressed: (){
                              // 发送action事件
                              store.dispatch(RefreshThemeDataAction(CommonUtils.getThemeDataByIndex(index)));
                            },
                          ),
                        );
                      }
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }

}