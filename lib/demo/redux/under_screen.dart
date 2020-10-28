
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/demo/redux/action/count_action.dart';
import 'package:flutterapp/demo/redux/state/count_state.dart';

class UnderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            StoreConnector<CountState, int>(
              converter: (store)  {
                return store.state.count;
                },
              builder: (context, count) {
                return Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: StoreConnector<CountState, VoidCallback>(
        converter: (state) {
          return () => state.dispatch(CountAction.increment);
        },
        builder: (context, voidCallback) {
          return FloatingActionButton(
            onPressed: voidCallback,
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }

}