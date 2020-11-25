import 'package:flutter/material.dart';
import 'package:flutterapp/demo/provider/my_change_notifier.dart';
import 'package:provider/provider.dart';

/// @Date：2020/11/24
/// @Author：songdongliang
/// Desc：

class ProviderTestPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterHomePage(),
    );
  }

}

class CounterHomePage extends StatelessWidget {

  final MyChangeNotifier notifier = MyChangeNotifier();

  @override
  Widget build(BuildContext context) {
    // MyChangeNotifier notifier = Provider.of(context);
    return ChangeNotifierProvider(
        create: (_) => notifier,
      child: Scaffold(
        appBar: AppBar(
          title: Text("计数器"),
        ),
        body: Consumer<MyChangeNotifier>(
            builder: (_, localNotifier, __) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${localNotifier.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: notifier.incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

}