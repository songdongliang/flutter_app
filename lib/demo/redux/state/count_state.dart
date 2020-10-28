
import 'package:flutter/material.dart';
import 'package:flutterapp/demo/redux/action/count_action.dart';

/// State中所有属性都应该是只读的
@immutable
class CountState {

  final int _count;

  get count => _count;

  CountState(this._count);

  CountState.initState(): _count = 0;
}

CountState reducer(CountState state, action) {
  if (action == CountAction.increment) {
    return CountState(state.count + 1);
  }
  return state;
}

