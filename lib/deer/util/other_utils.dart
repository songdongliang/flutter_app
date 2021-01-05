import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';
import 'package:flutterapp/deer/util/toast.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:url_launcher/url_launcher.dart';

/// @Date：2020/12/7
/// @Author：songdongliang
/// Desc：
class Utils {

  /// 调起拨号页
  static Future<void> launchTelURL(String phone) async {
    final String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('拨号失败! ');
    }
  }

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

  static String formatPrice(String price, {MoneyFormat format = MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(NumUtil.getDoubleByValueStr(price), MoneyUnit.YUAN, format: format);
  }
}