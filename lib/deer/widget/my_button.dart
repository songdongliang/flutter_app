import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/util/theme_utils.dart';

/// @Date：2020/12/9
/// @Author：songdongliang
/// Desc：
class MyButton extends StatelessWidget {

  const MyButton({
    Key key,
    this.text = '',
    @required this.onPressed
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return FlatButton(
        onPressed: onPressed,
        textColor: isDark ? SColors.dark_button_text : Colors.white,
        color: isDark ? SColors.dark_app_main : SColors.app_main,
        disabledTextColor: isDark ? SColors.dark_text_disabled : SColors.text_disabled,
        disabledColor: isDark ? SColors.dark_button_disabled : SColors.button_disabled,
        child: Container(
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(text, style: const TextStyle(fontSize: Dimens.font_sp18),),
        ),
    );
  }

}