

import 'package:flutter/cupertino.dart';

class InheritedProvider<T> extends InheritedWidget {

  final T data;

  InheritedProvider({@required this.data, Widget child}): super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    return true;
  }
  
}

class ChangeNotifier implements Listenable {

  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.add(listener);
  }

  void notifyListeners() {
    // 通知所有监听器
    listeners.forEach((element) => {element()});
  }
  
} 