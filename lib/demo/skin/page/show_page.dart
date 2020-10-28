import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/demo/skin/page/switch_page.dart';
import 'package:flutterapp/demo/skin/redux/SDLState.dart';

class ShowPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<SDLState, ThemeData>(
      converter: (store) => store.state.themeData,
      builder: (context, themeData) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Show Page"),
          ),
          body: Center(
            child: Container(
              width: 200,
              height: 100,
              color: themeData.primaryColor,
              alignment: Alignment.center,
              child: Text(
                "当前的颜色值",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed("switch_page");
            },
            child: Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }

}

Map<String, WidgetBuilder> routers = {
  "switch_page": (context) => SwitchPage()
};