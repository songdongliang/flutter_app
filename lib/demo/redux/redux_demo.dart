
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/demo/redux/state/count_state.dart';
import 'package:flutterapp/demo/redux/top_screen.dart';
import 'package:redux/redux.dart';

class ReduxDemo extends StatelessWidget {

  final Store<CountState> store;

  ReduxDemo(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
      child: MaterialApp(
        title: 'Redux Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: TopScreen(),
      ),
    );
  }

}