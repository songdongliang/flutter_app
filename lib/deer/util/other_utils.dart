import 'package:flutter/material.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';

/// @Date：2020/12/7
/// @Author：songdongliang
/// Desc：
class Utils {

  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(list.length, (index) => KeyboardActionsItem(
          focusNode: list[index],
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                child: Text('渣渣灰关闭'),
              ),
            );
          }
        ]
      ))
    );
  }
}