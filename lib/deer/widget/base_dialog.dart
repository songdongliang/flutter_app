import 'package:flutter/material.dart';
import 'package:flutterapp/deer/res/colors.dart';
import 'package:flutterapp/deer/res/dimens.dart';
import 'package:flutterapp/deer/res/gaps.dart';
import 'package:flutterapp/deer/res/styles.dart';
import 'package:flutterapp/deer/routers/navigator_utils.dart';

/// @Date：2021/1/4
/// @Author：songdongliang
/// Desc：
class BaseDialog extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final Widget child;
  final bool hiddenTitle;

  const BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.hiddenTitle = false,
    @required this.child
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    final Widget dialogTitle = Visibility(
      visible: !hiddenTitle,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
              hiddenTitle ? '' : title,
            style: TextStyles.textBold18,
          ),
        )
    );

    final Widget bottomButton = Row(
      children: <Widget>[
        _DialogButton(
          text: '取消',
          textColor: SColors.text_gray,
          onPressed: () {
            NavigatorUtils.goBack(context);
          },
        ),
        const SizedBox(
          height: 48.0,
          width: 6.0,
          child: VerticalDivider(),
        ),
        _DialogButton(
          textColor: Theme.of(context).primaryColor,
          onPressed: onPressed,
          text: '确定',
        )
      ],
    );

    final Widget body = Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gaps.vGap24,
          dialogTitle,
          Flexible(child: child),
          Gaps.vGap8,
          Gaps.line,
          bottomButton
        ],
      ),
    );

    return AnimatedPadding(
        padding: null,
        duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
          context: context,
          removeTop: true,
          removeBottom: true,
          removeLeft: true,
          removeRight: true,
          child: Center(
            child: SizedBox(
              width: 270.0,
              child: body,
            ),
          )
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const _DialogButton({
    Key key,
    this.text,
    this.textColor,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
          height: 48.0,
          child: FlatButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(fontSize: Dimens.font_sp18),
              ),
            textColor: textColor,
          ),
        )
    );
  }


}