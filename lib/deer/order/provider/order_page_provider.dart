import 'package:flutter/material.dart';

/// @Date：2020/12/29
/// @Author：songdongliang
/// Desc：
class OrderPageProvider extends ChangeNotifier {

  int _index = 0;
  int get index => _index;

  void refresh() {
    notifyListeners();
  }

  void setIndex(int index) {
    this._index = index;
    notifyListeners();
  }
}