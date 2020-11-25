import 'package:flutter/material.dart';

/// @Date：2020/11/24
/// @Author：songdongliang
/// Desc：

class MyChangeNotifier extends ChangeNotifier {

  int _counter = 0;

  int get counter => _counter;

  incrementCounter() {
    _counter++;
    notifyListeners();
  }

}