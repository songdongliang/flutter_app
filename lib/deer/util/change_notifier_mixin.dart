import 'package:flutter/material.dart';

/// @Date：2020/12/5
/// @Author：songdongliang
/// Desc：
mixin ChangeNotifierMixin<T extends StatefulWidget> on State<T> {

  Map<ChangeNotifier, List<VoidCallback>> _map;

  Map<ChangeNotifier, List<VoidCallback>> changeNotifier();


}